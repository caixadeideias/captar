require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "render home appropriate template" do
    get :show, id: 'home'
    assert_template 'layouts/home'
  end
end
