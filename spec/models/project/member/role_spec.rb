require 'rails_helper'

RSpec.describe Project::Member::Role, type: :model do
  
  fixtures :all

  it 'should create project member role' do
    member = project_members(:project_member_1_1) 
    role = Project::Member::Role.create(
      member_id: member.id,
      type: 3, # 'ui_designer'
    )
    expect(role.errors.full_messages).to eq([])
    expect(role.member).to eq(member)
  end

  it 'should return role accesses' do
    role = project_member_roles(:project_member_role_1_1)
    access_ids = [
      accesses(:access_1).id,
    ]
    role_accesses = role.accesses
    expect(role_accesses).to be
    expect(role_accesses.size).to eq(access_ids.size)
    role_accesses.each { |access| 
      expect(access_ids).to include(access.id)
    }
  end

end
