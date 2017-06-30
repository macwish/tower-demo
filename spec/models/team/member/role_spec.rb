require 'rails_helper'

RSpec.describe Team::Member::Role, type: :model do

  fixtures :all

  it 'should create team member role' do
    member = team_members(:team_member_1_1) 
    role = Team::Member::Role.create(
      member_id: member.id,
      type: 1, # 'staff'
    )
    expect(role.errors.full_messages).to eq([])
    expect(role.member).to eq(member)
  end

  it 'should return role accesses' do
    role = team_member_roles(:team_member_role_2_2)
    access_ids = [
      accesses(:access_7).id,
    ]
    role_accesses = role.accesses
    expect(role_accesses).to be
    expect(role_accesses.size).to eq(access_ids.size)
    role_accesses.each { |access| 
      expect(access_ids).to include(access.id)
    }
  end

end
