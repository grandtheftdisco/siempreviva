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