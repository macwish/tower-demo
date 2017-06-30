require 'rails_helper'

RSpec.describe Project, type: :model do

  fixtures :all

  before {
    @project = projects(:project_1_1)
  }

  it 'should create project' do
    team = teams(:team_1)
    project = Project.create(
      team_id: team.id,
      name: 'new project',
      description: 'description...',
      type: 0,  # standard
      is_private: true,
      status: 0,
      pinned: nil,
      icon: nil,
      color: nil,
      start_time: nil,
      end_time: nil,
      archived: false,
      removed: false
    )
    expect(project.errors.full_messages).to eq([])
    expect(project.team).to eq(team)
  end

  it 'should return project members' do
    member_ids = [
      project_members(:project_member_1_1).id,
      project_members(:project_member_1_2).id,
      project_members(:project_member_1_3).id,
      project_members(:project_member_1_4).id,
      project_members(:project_member_1_5).id,
    ]
    members = @project.members
    expect(members).to be
    expect(members.size).to eq(member_ids.size)
    members.each { |member| 
      expect(member_ids).to include(member.id)
    }
  end

  it 'should return project todo lists' do
    todo_list_ids = [
      project_todo_lists(:todo_list_1_1).id,
      project_todo_lists(:todo_list_1_2).id,
    ]
    todo_lists = @project.todo_lists
    expect(todo_lists).to be
    expect(todo_lists.size).to eq(todo_list_ids.size)
    todo_lists.each { |todo_list| 
      expect(todo_list_ids).to include(todo_list.id)
    }
  end

  it 'should return project related-events' do
    related_event_ids = [
      events(:event_1).id,
      events(:event_2).id,
      events(:event_3).id,
    ]
    related_events = @project.related_events
    expect(related_events).to be
    expect(related_events.size).to eq(related_event_ids.size)
    related_events.each { |related_event| 
      expect(related_event_ids).to include(related_event.id)
    }
  end

  it 'should implement OriginrelatedProtocol' do
    expect(@project.origin).to be
    expect(@project.origin).to eq(@project)
    expect(@project.origin_name).to be
    expect(@project.origin_name).to eq(@project.name)
  end

end
