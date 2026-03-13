require "test_helper"

class HandlePendingAsyncPaymentTest < ActiveSupport::TestCase
  setup do
    @cart = Cart.create!(session_id: "async_test_session", status: "open")
    @cart_item = CartItem.create!(cart: @cart, stripe_product_id: "prod_async", price: 1000, quantity: 1)
  end

  test "soft-deletes cart and sets status to pending when payment is processing" do
    checkout_session = stub(payment_status: "unpaid", payment_intent: "pi_123")
    payment_intent = stub(status: "processing")
    Stripe::PaymentIntent.stubs(:retrieve).with("pi_123").returns(payment_intent)

    result = WebhookSynchronizationService::HandlePendingAsyncPayment.call(
      checkout_session: checkout_session,
      cart: @cart
    )

    assert result
    assert_equal "pending", @cart.reload.status
    assert_not_nil @cart.deleted_at
    assert_empty CartItem.where(cart_id: @cart.id)
  end

  test "returns false and does not modify cart when payment_status is paid" do
    checkout_session = stub(payment_status: "paid")

    result = WebhookSynchronizationService::HandlePendingAsyncPayment.call(
      checkout_session: checkout_session,
      cart: @cart
    )

    assert_not result
    assert_nil @cart.reload.deleted_at
    assert_equal 1, @cart.cart_items.count
  end

  test "returns false when payment_status is unpaid but PI status is not processing" do
    checkout_session = stub(payment_status: "unpaid", payment_intent: "pi_456")
    payment_intent = stub(status: "requires_payment_method")
    Stripe::PaymentIntent.stubs(:retrieve).with("pi_456").returns(payment_intent)

    result = WebhookSynchronizationService::HandlePendingAsyncPayment.call(
      checkout_session: checkout_session,
      cart: @cart
    )

    assert_not result
    assert_nil @cart.reload.deleted_at
    assert_equal 1, @cart.cart_items.count
  end

  test "returns false when payment_status is no_payment_required" do
    checkout_session = stub(payment_status: "no_payment_required")

    result = WebhookSynchronizationService::HandlePendingAsyncPayment.call(
      checkout_session: checkout_session,
      cart: @cart
    )

    assert_not result
    assert_nil @cart.reload.deleted_at
  end
end
