class HardDeleteAbandonedCartsJob < ApplicationJob
  queue_as :default

  def perform
    soft_deleted_carts = Cart.with_deleted
                             .where(status: "soft_deleted")
    return if soft_deleted_carts.empty?

    soft_deleted_carts.each do |cart|
      return if Time.now - cart.deleted_at < 30.days
      cart.destroy!
    end
  end
end