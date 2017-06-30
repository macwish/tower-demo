require 'rails_helper'

RSpec.describe Project::TodoItem, type: :model do
  
  fixtures :all

  before {
    @todo = project_todos(:todo_1_1)
  }

  it 'should create todo item' do
    todo_item = Project::TodoItem.create(
      todo_id: @todo.id,
      description: 'new description',
      completed: false
    )
    expect(todo_item.errors.full_messages).to eq([])
    expect(todo_item.todo).to eq(@todo)
    expect(todo_item.project).to eq(@todo.project)
  end

end
