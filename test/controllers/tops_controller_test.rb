require 'test_helper'

class TopsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get tops_show_url
    assert_response :success
  end

end
