module Admins
  class OrdersController < Admins::ApplicationController
    def index
      @all_orders = Order.all
      @unfulfilled_orders = Order.where(tracking_number = nil)
    end

    def show
    end

    def edit
    end

    def update
    end
  end
end