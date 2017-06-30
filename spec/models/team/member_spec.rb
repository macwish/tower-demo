require 'rails_helper'

RSpec.describe Team::Member, type: :model do
  
  fixtures :all

  before {
    @team = teams(:team_1)
    @user = users(:user_1)
  }

  it 'should create team member' do
    user = users(:user_6)  # user_6 not belongs to @team
    member = Team::Member.create(
      team_id: @team.id,
      user_id: user.id,
    )
    expect(member.errors.full_messages).to eq([])
    expect(member.team).to eq(@team)
    expect(member.user).to eq(user)
  end

  it 'should not create team member with existing member' do
    member = Team::Member.create(
      team_id: @team.id,
      user_id: @user.id,  # @user belongs to @team already
    )
    expect(member.errors.full_messages).to include('User has already been taken')
  end

  it 'should return member roles' do
    member = team_members(:team_member_1_1)
    role_ids = [
      team_member_roles(:team_member_role_1_1).id
    ]
    member_roles = member.roles
    expect(member_roles).to be
    expect(member_roles.size).to eq(role_ids.size)
    member_roles.each { |role| 
      expect(role_ids).to include(role.id)
    }
  end

end
