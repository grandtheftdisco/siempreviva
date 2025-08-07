module Admins
  class OrdersController < Admins::ApplicationController
    ORDERS_PER_PAGE = 2
    before_action :set_order, only: %i[ edit update show ]

    def index
      @page = params.fetch(:page, 0)
                    .to_i
      @orders_per_page = ORDERS_PER_PAGE
      @total_unfulfilled_orders = Order.where(tracking_number: nil).count
      @unfulfilled_orders = Order.where(tracking_number: nil)
                                 .offset(@page * @orders_per_page)
                                 .limit(@orders_per_page)

      # !!!!!!!!!!! TODO - abstract this into a private method
      # Fetch Stripe info for each order - cp
      @stripe_infos = @unfulfilled_orders.each_with_object({}) do |order, hash|
        begin
          stripe_transaction = Stripe::PaymentIntent.retrieve({
            id: order.payment_intent_id,
            expand: ['shipping', 'customer']
          })
          Rails.logger.debug "---------------->shipping info: #{stripe_transaction.shipping.inspect}"
          hash[order.id] = {
            shipping_address: stripe_transaction.shipping&.address&.to_h,
            customer: stripe_transaction.customer,
            charge: Stripe::Charge.retrieve({ id: stripe_transaction.latest_charge }),
          }
        rescue Stripe::StripeError => e
          hash[order.id] = { error: e.message }
        end
      end
    end

    def show
      # view elements
      @order = Order.find(params.expect(:id))
      @stripe_transaction = Stripe::PaymentIntent.retrieve({
        id: @order.payment_intent_id,
        expand: ['shipping', 'customer']
      })
      @shipping_address = @stripe_transaction.shipping
                                            &.address
                                            &.to_h
      @customer = @stripe_transaction.customer

      @line_items = fetch_line_items(@order.payment_intent_id)
      @stripe_charge = Stripe::Charge.retrieve({
        id: @stripe_transaction.latest_charge
      })
      @customer_info = @stripe_charge.billing_details
    end

    def edit
    end

    def update
      Rails.logger.debug "\e[1;45m---->Params: #{params.inspect}\n"
      if !params[:ship_confirmation]
        flash[:alert] = "You must confirm shipment before you can mark this order as 'shipped'."
        redirect_to edit_admins_order_path(@order) and return
      end

      if @order.update(order_params)
        AdminService::UpdateOrderTracking.call(order: @order)
        OrderMailer.shipped(@order).deliver_later
        Rails.logger.debug "order tracking: #{@order.tracking_number}"
        redirect_to admins_orders_url
        flash[:alert] = "Order was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # find a way to integrate this into #index to stay restful
    def archive
      @page = params.fetch(:page, 0)
                    .to_i
      @orders_per_page = ORDERS_PER_PAGE
      @fulfilled_orders = Order.where.not(tracking_number: nil)
                               .offset(@page * @orders_per_page)
                               .limit(@orders_per_page)
                               .order(:created_at)
      @total_fulfilled_orders = Order.where.not(tracking_number: nil).count

      Rails.logger.debug "--------->total fulfilled orders: #{@total_fulfilled_orders.inspect}"

      # TODO - abstract this into a private method
      @stripe_infos = @fulfilled_orders.each_with_object({}) do |order, hash|
        begin
          stripe_transaction = Stripe::PaymentIntent.retrieve({
            id: order.payment_intent_id,
            expand: ['shipping', 'customer']
          })
          Rails.logger.debug "---------------->shipping info: #{stripe_transaction.shipping.inspect}"
          hash[order.id] = {
            shipping_address: stripe_transaction.shipping&.address&.to_h,
            customer: stripe_transaction.customer,
            charge: Stripe::Charge.retrieve({ id: stripe_transaction.latest_charge }),
          }
        rescue Stripe::StripeError => e
          hash[order.id] = { error: e.message }
        end
      end

      if params[:status].present?
        @orders = Order.where(status: params[:status])
      else
        @orders = Order.all
      end
    end

    private

    def fetch_line_items(payment_intent_id)
      begin
        # ensures no duplicate sessions for same payment intent
        session_list = Stripe::Checkout::Session.list({
          payment_intent: payment_intent_id,
          expand: ['data.line_items']
        })

        if session_list.data.empty?
          return { error: "No checkout session found for this payment."}
    
        end
        
        session = session_list.data.first
        line_items = session.line_items.data

        detailed_line_items = fetch_product_details(line_items)

        return detailed_line_items
      rescue Stripe::StripeError => e
        return { error: e.message }
      end
    end

    def fetch_product_details(line_items)
      line_items.map do |item|
        price = Stripe::Price.retrieve({
          id: item.price.id,
          expand: ['product']
        })

        # return hash of line item product details
        {
          id: item.id,
          quantity: item.quantity,
          amount_total: item.amount_total,
          unit_amount: price.unit_amount,
          currency: price.currency,
          product: {
            id: price.product.id,
            name: price.product.name,
            description: price.product.description,
            images: price.product.images,
            metadata: price.product.metadata
          }
        }
      end
    end

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order)
            .permit(:tracking_number,
                    :status)
    end
  end
end