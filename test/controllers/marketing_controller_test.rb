require "test_helper"

class MarketingControllerTest < ActionDispatch::IntegrationTest
  test "should get gallery" do
    get gallery_url
    assert_response :success 
  end
end
