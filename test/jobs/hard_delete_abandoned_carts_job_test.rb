require "test_helper"

class HardDeleteAbandonedCartsJobTest < ActiveJob::TestCase
  test "when an abandoned cart is 30 days old, it will be hard deleted" do
    travel -40.days
    
    cart = Cart.create!(created_at: Time.now,
                        updated_at: Time.now,
                        status: "soft_deleted",
                        deleted_at: Time.now + 1.day,
                        session_id: "si_126")

    HardDeleteAbandonedCartsJob.perform_now

    abandoned_carts = Cart.where(status: "soft_deleted")

    assert_empty(abandoned_carts)
  end
end