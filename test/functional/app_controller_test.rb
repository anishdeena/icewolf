require 'test_helper'

class AppControllerTest < ActionController::TestCase
  test "should get loader" do
    get :loader
    assert_response :success
  end

end
