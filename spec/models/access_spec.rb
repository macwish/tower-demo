require 'rails_helper'

RSpec.describe Access, type: :model do

  fixtures :all

  it "should create an access" do
    role = project_member_roles(:project_member_role_1_1)
    access = Access.create!(
      scope: Project.name,
      permission: Permission.types['full'],
      accessrelated_type: role.class.name,
      accessrelated_id: role.id
    )
    expect(Access.order('created_at').last).to eq(access)
  end
  
end
