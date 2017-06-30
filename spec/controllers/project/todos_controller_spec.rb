require 'rails_helper'

RSpec.describe Project::TodosController, type: :controller do

  render_views true
  fixtures :all

  describe "GET #index" do
    it 'should responds project list with 200 status' do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it 'should responds todo info with 200 status' do
      todo = project_todos(:todo_1_1)
      get :show, params: { id: todo.id }
      expect(response).to be_success
      expect(response.body).to have_title("Todo/Show - #{todo.id}")
    end
  end

  describe "GET #edit" do
    it 'should responds todo edit form with 200 status' do
      todo = project_todos(:todo_1_1)
      get :edit, params: { id: todo.id }
      expect(response).to be_success
      expect(response.body).to have_title("Todo/Edit - #{todo.id}")
    end
  end

  describe "POST #create" do
    it 'should create a new todo' do
      todo_count = Project::Todo.all.size
      todo_list = project_todo_lists(:todo_list_1_1)
      post :create, params: {
        project_todo: {
          todo_list_id: todo_list.id,
          content: 'new todo connent ...',
          assigned_to_member_id: nil,
          deadline: nil,
          completed: false,
          trashed: false,
        }
      }
      expect(Project::Todo.all.size).to eq(todo_count + 1)
      expect(response).to redirect_to(Project::Todo.order('created_at').last)
    end

    it 'should create a new todo with assigned user' do
      todo_count = Project::Todo.all.size
      todo_list = project_todo_lists(:todo_list_1_1)
      user = users(:user_1)
      post :create, params: {
        project_todo: {
          todo_list_id: todo_list.id,
          content: 'new todo connent ...',
          assigned_to_member_id: user.id,
          deadline: nil,
          completed: false,
          trashed: false,
        }
      }
      expect(Project::Todo.all.size).to eq(todo_count + 1)
      expect(response).to redirect_to(Project::Todo.order('created_at').last)
    end

    it 'should create a new todo with assigned user and deadline' do
      todo_count = Project::Todo.all.size
      todo_list = project_todo_lists(:todo_list_1_1)
      user = users(:user_1)
      post :create, params: {
        project_todo: {
          todo_list_id: todo_list.id,
          content: 'new todo connent ...',
          assigned_to_member_id: user.id,
          deadline: Time.now.to_i,
          completed: false,
          trashed: false,
        }
      }
      expect(Project::Todo.all.size).to eq(todo_count + 1)
      expect(response).to redirect_to(Project::Todo.order('created_at').last)
    end
  end

  describe "POST #update" do
    it 'should update a todo (content)' do
      todo = project_todos(:todo_1_1)
      new_content = 'new connent ...' 
      post :update, params: {
        id: todo.id,
        project_todo: {
          content: new_content
        }
      }
      new_todo = Project::Todo.find(todo.id)
      expect(new_todo.content).to eq(new_content)
      expect(response).to redirect_to(todo)
    end

    it 'should update a todo (assigned user)' do
      todo = project_todos(:todo_1_1)
      new_user = users(:user_2)
      post :update, params: {
        id: todo.id,
        project_todo: {
          assigned_to_member_id: new_user.id,
        }
      }
      new_todo = Project::Todo.find(todo.id)
      expect(new_todo.assigned_to_member_id).to eq(new_user.id)
      expect(response).to redirect_to(todo)
    end

    it 'should update a todo (deadline)' do
      todo = project_todos(:todo_1_1)
      new_deadline = Time.now.to_i
      post :update, params: {
        id: todo.id,
        project_todo: {
          deadline: new_deadline
        }
      }
      new_todo = Project::Todo.find(todo.id)
      expect(new_todo.deadline).to eq(new_deadline)
      expect(response).to redirect_to(todo)
    end

    it 'should update a todo (completed)' do
      todo = project_todos(:todo_1_1)
      post :update, params: {
        id: todo.id,
        project_todo: {
          completed: true,
        }
      }
      new_todo = Project::Todo.find(todo.id)
      expect(new_todo.completed).to eq(true)
      expect(response).to redirect_to(todo)
    end
  end

  describe "POST #destroy" do
    it 'should destroy a todo' do
      todo_count = Project::Todo.all.size
      todo = project_todos(:todo_1_1)
      post :destroy, params: {
        id: todo.id
      }
      expect(Project::Todo.all.size).to eq(todo_count - 1)
      expect(response).to redirect_to(project_todos_url)
    end
  end
  
end
