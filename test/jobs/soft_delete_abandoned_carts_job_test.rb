require "test_helper"

class SoftDeleteAbandonedCartsJobTest < ActiveJob::TestCase
  test "when a cart is 24 hours old, it will be soft deleted" do
    cart = Cart.create!(created_at: Time.now,
                        updated_at: Time.now,
                        status: "open",
                        session_id: "si_125")
    travel 2.days

    SoftDeleteAbandonedCartsJob.perform_now

    open_carts = Cart.where(status: "open")

    assert_empty(open_carts)
  end
end