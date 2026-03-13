class SoftDeletePendingCartJob < ApplicationJob
  def perform(cart)
    cart.soft_delete_records
    Rails.logger.info "--- Cart ##{cart.id} has been soft deleted"
  end
end