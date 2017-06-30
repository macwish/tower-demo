require 'rails_helper'

RSpec.describe User, type: :model do

  fixtures :all

  before {
    @user = users(:user_1)
  }
  
  it 'should create a new user' do
    name = 'new_user'
    user = User.create(
      email: name + '@example.com',
      password: 'my_raw_passwd',
      name: name,
      status: 0,
      removed: false,
    )
    expect(user).to be
    expect(user.errors.full_messages).to eq([])
    expect(user.display_name).to be
    expect(user.avatar).to be
    expect(user.projects).to be_nil
  end

  it 'should not create user with existing email' do
    existing_user = users(:user_1)
    name = 'new_user'
    user = User.create(
      email: existing_user.email,
      password: 'my_raw_passwd',
      name: name,
      status: 0,
      removed: false,
    )
    expect(user).to be
    expect(user.errors.full_messages).to include('Email has already been taken')
  end

  it 'should get teams associated to user' do
    team_ids = [
      teams(:team_1).id, 
    ]
    @user.created_teams.each { |team|
      expect(team_ids).to include(team.id)
    }
    @user.admined_teams.each { |team|
      expect(team_ids).to include(team.id)
    }
  end

  it 'should get team members associated to user' do
    member_ids = [
      team_members(:team_member_1_1).id, 
    ]
    expect(@user.team_members.size).to eq(member_ids.size)
    @user.team_members.each { |member| 
      expect(member_ids).to include(member.id)
    }
  end

  it 'should get project members associated to user' do
    member_ids = [
      project_members(:project_member_1_1).id, 
      project_members(:project_member_2_1).id,
    ]
    expect(@user.project_members.size).to eq(member_ids.size)
    @user.project_members.each { |member| 
      expect(member_ids).to include(member.id)
    }
  end

  it 'should get ptoject todos assigned to user' do
    todo_ids = [
      project_todos(:todo_1_1).id, 
      project_todos(:todo_1_2).id,
      project_todos(:todo_1_3).id,
      project_todos(:todo_1_5).id,
    ]
    expect(@user.project_todos.size).to eq(todo_ids.size)
    @user.project_todos.each { |todo| 
      expect(todo_ids).to include(todo.id)
    }
  end

  it 'should get user comments' do
    comment_ids = [
      comments(:comment_1).id,
      comments(:comment_2).id,
    ]
    expect(@user.comments.size).to eq(comment_ids.size)
    @user.comments.each { |comment| 
      expect(comment_ids).to include(comment.id)
    }
  end

  it 'should get user events' do
    event_ids = [
      events(:event_1).id,
      events(:event_2).id,
      events(:event_3).id,
    ]
    expect(@user.events.size).to eq(event_ids.size)
    @user.events.each { |event| 
      expect(event_ids).to include(event.id)
    }
  end

  it 'should get user auths' do
    auth_ids = [
      auths(:auth_1).id,
    ]
    expect(@user.auths.size).to eq(auth_ids.size)
    @user.auths.each { |auth| 
      expect(auth_ids).to include(auth.id)
    }
  end

  it 'should get projects associated to user' do
    user = users(:user_1)
    project_ids = [
      projects(:project_1_1).id, 
      projects(:project_1_2).id
    ]
    expect(user.projects.size).to eq(project_ids.size)
    user.projects.each { |project| 
      expect(project_ids).to include(project.id)
    }
  end

end
