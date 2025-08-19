class SoftDeleteAbandonedCartsJob < ApplicationJob
  queue_as :default

  def perform
    open_carts = Cart.where(status: "open")
    return if open_carts.empty?

    open_carts.each do |cart|
      return if Time.now - cart.updated_at < 24.hours
      cart.soft_delete_records
    end
  end
end