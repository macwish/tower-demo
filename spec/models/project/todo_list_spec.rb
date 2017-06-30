require 'rails_helper'

RSpec.describe Project::TodoList, type: :model do
  
  fixtures :all

  before {
    @project = projects(:project_1_1)
  }

  it 'should create todo list' do
    todo_list = Project::TodoList.create(
      project_id: @project.id,
      name: 'new name',
      description: 'new description',
      trashed: false
    )
    expect(todo_list.errors.full_messages).to eq([])
    expect(todo_list.project).to eq(@project)
  end

  it 'should return todos' do
    todo_list = project_todo_lists(:todo_list_1_1)
    todo_ids = [
      project_todos(:todo_1_1).id,
      project_todos(:todo_1_2).id,
      project_todos(:todo_1_3).id,
      project_todos(:todo_1_4).id,
      project_todos(:todo_1_5).id,
    ]
    todos = todo_list.todos
    expect(todos).to be
    expect(todos.size).to eq(todo_ids.size)
    todos.each { |todo| 
      expect(todo_ids).to include(todo.id)
    }
  end

end
