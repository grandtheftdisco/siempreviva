require "test_helper"

class CheckoutSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should return 422 when cart is empty" do
    cart = carts(:empty)

    session_mock = mock('session')
    session_mock.stubs(:id).returns(cart.session_id)
    session_mock.stubs(:to_s).returns(cart.session_id)

    ApplicationController.any_instance.stubs(:session).returns(session_mock)

    post checkout_sessions_url
    assert_response :unprocessable_entity

    json_response = JSON.parse(response.body)
    assert_equal "Cart is empty", json_response["error"]
  end
end
