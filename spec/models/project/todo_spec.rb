require 'rails_helper'

RSpec.describe Project::Todo, type: :model do
  
  fixtures :all

  before {
    @todo_list = project_todo_lists(:todo_list_1_1)
    @todo = project_todos(:todo_1_1)
    @user = users(:user_1)
    @event_count = Event.all.size
  }

  it 'should create todo' do
    todo = Project::Todo.create(
      todo_list_id: @todo_list.id,
      content: 'new todo',
      assigned_to_member_id: @user.id,
      deadline: Time.now.to_i,
      completed: false,
      trashed: false,
    )
    expect(todo.errors.full_messages).to eq([])
    expect(todo.todo_list).to eq(@todo_list)
    expect(todo.assigned_to_member).to eq(@user)
    expect(todo.project).to eq(@todo_list.project)
    # 
    expect(todo.title).to be
    expect(todo.completed_status).to be
    expect(todo.trashed_status).to be
  end

  it 'should generate some events related to todo' do
    
    def check_action(action, eventrelated = @todo)
      expect(Event.all.size).to eq(@event_count + 1)
      @event_count = Event.all.size
      last_event = Event.order('created_at').last
      expect(last_event.action).to eq(action)
      expect(last_event.eventrelated).to eq(eventrelated)
    end

    ApplicationRecord.current_user = @user
    @event_count = Event.all.size
    
    # create todo
    @todo = Project::Todo.create!(
      todo_list_id: @todo_list.id,
      content: 'new todo foo',
      assigned_to_member_id: nil,
      deadline: nil,
      completed: false,
      trashed: false,
    )
    check_action('created')

    # update todo.content
    @todo.content = 'updated content'
    @todo.save!
    check_action('updated_content')

    # finish todo
    @todo.completed = true
    @todo.save!
    check_action('finished')

    # rework todo
    @todo.completed = false
    @todo.save!
    check_action('reworked')

    # assign todo
    @todo.assigned_to_member_id = @user.id
    @todo.save!
    check_action('assigned')

    # re-assign todo
    @todo.assigned_to_member_id = users(:user_2).id
    @todo.save!
    check_action('reassigned')

    # re-assign todo
    @todo.assigned_to_member_id = nil
    @todo.save!
    check_action('reassigned')

    # update todo deadline
    @todo.deadline = Time.now.to_i
    @todo.save!
    check_action('changed_deadline')

    # update todo deadline
    @todo.deadline = Time.now.to_i + 1.day
    @todo.save!
    check_action('changed_deadline')

    # comment to todo
    comment = Comment.create!(
      content: 'comment to todo',
      user_id: @user.id,
      commentable: @todo,
    )
    check_action('commented', comment)

  end

  it 'should return todo items' do
    todo_item_ids = [
      project_todo_items(:todo_item_1_1).id,
      project_todo_items(:todo_item_1_2).id,
      project_todo_items(:todo_item_1_3).id,
    ]
    expect(@todo.todo_items.size).to eq(todo_item_ids.size)
    @todo.todo_items.each { |todo_item| 
      expect(todo_item_ids).to include(todo_item.id)
    }
  end

  it 'should return todo comments' do
    comment_ids = [
      comments(:comment_1).id,
      comments(:comment_2).id,
      comments(:comment_3).id,
    ]
    expect(@todo.comments.size).to eq(comment_ids.size)
    @todo.comments.each { |comment| 
      expect(comment_ids).to include(comment.id)
    }
  end

  it 'should return todo related-event' do
    event_ids = [
      events(:event_1).id,
      events(:event_2).id,
    ]
    expect(@todo.related_events.size).to eq(event_ids.size)
    @todo.related_events.each { |event| 
      expect(event_ids).to include(event.id)
    }
  end

  it 'should implement EventrelatedProtocol' do
    expect(Project::Todo.self_description).to be
    expect(Project::Todo.self_description).to eq(I18n.t(Project::Todo.name))
    expect(@todo.event_target).to be
    expect(@todo.event_target).to eq(@todo)
    expect(@todo.event_title).to be
    expect(@todo.event_title).to eq(@todo.title)
  end

  it 'should implement CommentableProtocol' do
    expect(@todo.comment_title).to be
    expect(@todo.comment_title).to eq(@todo.title)
  end

end
