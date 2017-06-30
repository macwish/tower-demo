require 'rails_helper'

RSpec.describe Event, type: :model do

  fixtures :all

  before {
    @user = users(:user_1)
    @todo = project_todos(:todo_1_1)
    ApplicationRecord.current_user = @user
  }

  it 'should create a new event' do
    event = Event.create(
      type: 1,  # 'feed'
      user_id: @user.id,
      action: 1,  # 'created'
      target: 'Project::Todo',
      time: Time.now.to_i,
      info: nil,
      eventrelated: @todo,
      originrelated: @todo.project,
    )
    expect(event).to be
    expect(event.eventrelated).to eq(@todo)
    expect(event.eventrelated.event_target).to eq(@todo)
    expect(event.originrelated).to eq(@todo.project)
    expect(event.target).to eq(Project::Todo.self_description)
  end

end
