require "test_helper"

class Public::ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_projects_show_url
    assert_response :success
  end

  test "should get new" do
    get public_projects_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_projects_edit_url
    assert_response :success
  end
end
