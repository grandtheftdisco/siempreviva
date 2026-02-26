require "test_helper"

class CheckoutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @checkout = checkouts(:one)
  end

  test "should get new" do
    # Use existing cart fixture
    cart = carts(:mary)
    
    # Mock the cart validation service to return the cart without API calls
    CartService::ValidateCart.stubs(:call).returns([cart, [], []])
    CartService::CalculateCart.stubs(:call).returns(1000) # Return a mock total
    
    # Mock the session.id to match the cart's session_id  
    session_mock = mock('session')
    session_mock.stubs(:id).returns(cart.session_id)
    session_mock.stubs(:to_s).returns(cart.session_id)
    
    ApplicationController.any_instance.stubs(:session).returns(session_mock)
    
    get new_checkout_url
    assert_response :success
  end

  test "should show checkout when session status is complete" do
    # Create a mock Stripe session with 'complete' status
    mock_stripe_session = mock('stripe_session')
    mock_stripe_session.stubs(:status).returns('complete')
    mock_stripe_session.stubs(:id).returns(@checkout.stripe_checkout_session_id)
    
    Stripe::Checkout::Session.stubs(:retrieve)
                            .with(@checkout.stripe_checkout_session_id)
                            .returns(mock_stripe_session)
    
    get checkout_url(@checkout.stripe_checkout_session_id)
    assert_response :success
    
    # Verify the content for complete status
    assert_select "h1", text: /Thanks for shopping.*with Siempreviva!/m
    assert_select ".subtitle", text: "we'll get started on your order right away."
    assert_select ".order-number", text: /#123456/
    assert_select ".receipt-notice", text: /please check your email for your receipt/
    assert_select ".image-placeholder", text: "Order Confirmation Image"
  end

  test "should show checkout when session status is open" do
    # Create a mock Stripe session with 'open' status
    mock_stripe_session = mock('stripe_session')
    mock_stripe_session.stubs(:status).returns('open')
    mock_stripe_session.stubs(:id).returns(@checkout.stripe_checkout_session_id)
    
    Stripe::Checkout::Session.stubs(:retrieve)
                            .with(@checkout.stripe_checkout_session_id)
                            .returns(mock_stripe_session)
    
    get checkout_url(@checkout.stripe_checkout_session_id)
    assert_response :success
    
    # Verify the content for open status
    assert_select "h1", text: /Your payment is.*being processed!/m
    assert_select ".subtitle", text: "we'll email you when it's complete."
    assert_select ".image-placeholder", text: "Processing Payment Image"
    
    # Should NOT show order details for open status
    assert_select ".order-number", false
    assert_select ".receipt-notice", false
  end

  test "should redirect when session status is expired" do
    # Create a mock Stripe session with 'expired' status
    mock_stripe_session = mock('stripe_session')
    mock_stripe_session.stubs(:status).returns('expired')
    mock_stripe_session.stubs(:id).returns(@checkout.stripe_checkout_session_id)
    
    Stripe::Checkout::Session.stubs(:retrieve)
                            .with(@checkout.stripe_checkout_session_id)
                            .returns(mock_stripe_session)
    
    get checkout_url(@checkout.stripe_checkout_session_id)
    
    # Should redirect to new checkout path
    assert_redirected_to new_checkout_path
  end

  test "should show error state for unknown session status" do
    # Create a mock Stripe session with unknown status
    mock_stripe_session = mock('stripe_session')
    mock_stripe_session.stubs(:status).returns('unknown_status')
    mock_stripe_session.stubs(:id).returns(@checkout.stripe_checkout_session_id)
    
    Stripe::Checkout::Session.stubs(:retrieve)
                            .with(@checkout.stripe_checkout_session_id)
                            .returns(mock_stripe_session)
    
    get checkout_url(@checkout.stripe_checkout_session_id)
    assert_response :success
    
    # Verify the content for error state
    assert_select "h1", text: /Something.*went wrong./m
    assert_select ".subtitle a[href=?]", new_contact_form_path
    assert_select ".image-placeholder", text: "Error State Image"
  end

  test "should return 404 when local checkout record not found" do
    get checkout_url("nonexistent_session_id")
    assert_response :not_found
    assert_equal "Local Checkout record not found", response.body
  end

  test "should handle Stripe InvalidRequestError" do
    Stripe::Checkout::Session.stubs(:retrieve)
                            .raises(Stripe::InvalidRequestError.new("Invalid session", "param"))
    
    get checkout_url(@checkout.stripe_checkout_session_id)
    assert_response :not_found
    assert_equal "Invalid Checkout Session", response.body
  end

  test "should handle Stripe StripeError" do
    Stripe::Checkout::Session.stubs(:retrieve)
                            .raises(Stripe::StripeError.new("API Error"))
    
    get checkout_url(@checkout.stripe_checkout_session_id)
    assert_response :service_unavailable
    assert_equal "Payment processing error", response.body
  end

  test "should handle unexpected StandardError" do
    Stripe::Checkout::Session.stubs(:retrieve)
                            .raises(StandardError.new("Unexpected error"))
    
    get checkout_url(@checkout.stripe_checkout_session_id)
    assert_response :internal_server_error
    assert_equal "An unexpected error occurred", response.body
  end
end
