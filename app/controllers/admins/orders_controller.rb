module Admins
  class OrdersController < Admins::ApplicationController
    before_action :set_order, only: %i[ edit update show ]

    def index
      @unfulfilled_orders = Order.where(tracking_number: nil)
    end

    def show
    end

    def edit
    end

    def update
      # needs to move to service object
      begin
        intent = Stripe::PaymentIntent.update(
          @order.payment_intent_id,
          metadata: { tracking_number: @order.tracking_number }
        )
        Rails.logger.info "Successfully added tracking number to PaymentIntent #{intent.id}"
      rescue Stripe::StripeError => e
        Rails.logger.warn "Error: #{e.message}"
      end


      if @order.update(order_params)
        redirect_to admins_orders_url
        # FIXME - this ain't showin
        flash.now[:alert] = "Order was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def archive
      @orders = Order.all
    end

    private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order)
            .permit(:tracking_number)
    end
  end
end