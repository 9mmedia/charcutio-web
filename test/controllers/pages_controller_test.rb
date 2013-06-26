require 'test_helper'

class PagesControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
    assert_template 'index'
  end

end
