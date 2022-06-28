require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get users_show" do
    get admins_users_show_url
    assert_response :success
  end

  test "should get articles_show" do
    get admins_articles_show_url
    assert_response :success
  end

end
