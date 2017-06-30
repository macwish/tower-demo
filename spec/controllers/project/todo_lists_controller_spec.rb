require 'rails_helper'

RSpec.describe Project::TodoListsController, type: :controller do

  render_views true
  fixtures :all

  describe 'GET #show' do
    it 'should responds todo list info with 200 status' do
      todo_list = project_todo_lists(:todo_list_1_1)
      get :show, params: { id: todo_list.id }
      expect(response).to be_success
      expect(response.body).to have_title("TodoList/Show - #{todo_list.name}")
    end
  end

end
