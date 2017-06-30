require 'rails_helper'

RSpec.describe Comment, type: :model do

  fixtures :all

  before {
    @user = users(:user_1)
    @todo = project_todos(:todo_1_1)
    ApplicationRecord.current_user = @user
  }

  it 'should create a new comment (and auto create the related-event)' do
    comment = Comment.create(
      content: 'my comment content',
      user_id: @user.id,
      commentable: @todo
    )
    expect(comment).to be
    last_event = Event.order('created_at').last
    expect(last_event.eventrelated).to eq(comment)
  end

  it 'should implement EventrelatedProtocol' do
    comment = Comment.create(
      content: 'my comment content',
      user_id: @user.id,
      commentable: @todo
    )
    expect(Comment.self_description).to eq(I18n.t(Comment.name))
    expect(comment.event_target).to eq(@todo)
    expect(comment.event_title).to eq(@todo.title)
  end

end
