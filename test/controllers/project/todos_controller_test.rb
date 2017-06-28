require 'test_helper'

class Project::TodosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get project_todo_index_url
    assert_response :success
  end

end
