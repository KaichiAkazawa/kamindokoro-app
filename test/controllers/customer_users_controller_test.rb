require 'test_helper'

class CustomerUsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get customer_users_show_url
    assert_response :success
  end
end
