require 'rails_helper'

RSpec.describe Project::Member, type: :model do
  
  fixtures :all

  before {
    @project = projects(:project_1_1)
    @user = users(:user_1)
  }

  it 'should create project member' do
    user = users(:user_6)  # user_6 not belongs to @team
    member = Project::Member.create(
      project_id: @project.id,
      user_id: user.id,
    )
    expect(member.errors.full_messages).to eq([])
    expect(member.project).to eq(@project)
    expect(member.user).to eq(user)
  end

  it 'should not create project member with existing member' do
    member = Project::Member.create(
      project_id: @project.id,
      user_id: @user.id,  # @user belongs to @project already
    )
    expect(member.errors.full_messages).to include('User has already been taken')
  end

  it 'should return member roles' do
    member = project_members(:project_member_1_1)
    role_ids = [
      project_member_roles(:project_member_role_1_1).id
    ]
    member_roles = member.roles
    expect(member_roles).to be
    expect(member_roles.size).to eq(role_ids.size)
    member_roles.each { |role| 
      expect(role_ids).to include(role.id)
    }
  end

end
