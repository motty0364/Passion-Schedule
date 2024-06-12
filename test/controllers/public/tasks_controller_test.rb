require "test_helper"

class Public::TasksControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_tasks_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_tasks_edit_url
    assert_response :success
  end
end
