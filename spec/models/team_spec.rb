require 'rails_helper'

RSpec.describe Team, type: :model do

  fixtures :all

  before {
    @team = teams(:team_1)
  }

  it 'should create a new team' do 
    user1 = users(:user_1)
    user2 = users(:user_2)
    team = Team.create!(
      name: 'a new team',
      creator_id: user1.id,
      admin_id: user2.id,
      removed: false
    )
    expect(team.creator).to eq(user1)
    expect(team.admin).to eq(user2)
  end

  it 'should return team members' do
    member_ids = [
      team_members(:team_member_1_1).id,
      team_members(:team_member_1_2).id,
      team_members(:team_member_1_3).id,
      team_members(:team_member_1_4).id,
      team_members(:team_member_1_5).id,
    ]
    members = @team.members
    expect(members).to be
    expect(members.size).to eq(member_ids.size)
    members.each { |member| 
      expect(member_ids).to include(member.id)
    }
  end

  it 'should return team projects' do
    project_ids = [
      projects(:project_1_1).id,
      projects(:project_1_2).id,
    ]
    team_projects = @team.projects
    expect(team_projects).to be
    expect(team_projects.size).to eq(project_ids.size)
    team_projects.each { |project| 
      expect(project_ids).to include(project.id)
    }
  end

end
