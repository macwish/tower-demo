require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  render_views true
  fixtures :all

  describe 'GET #show' do
    it 'should responds comment info with 200 status' do
      comment = comments(:comment_1)
      get :show, params: { id: comment.id }
      expect(response).to be_success
      expect(response.body).to have_title("Comment/Show - #{comment.id}")
    end
  end

  describe 'POST #create' do
    it 'should create a new comment with 302 status' do
      comment_count = Comment.all.size
      todo = project_todos(:todo_1_1)
      post :create, params: {
        comment: {
          content: 'new comment connent ...',
          commentable_id: todo.id,
          commentable_type: todo.class.name
        }
      }
      expect(Comment.all.size).to eq(comment_count + 1)
      expect(response).to redirect_to(todo)
    end
  end

end
