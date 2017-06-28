class Team < ApplicationRecord

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  has_one :admin,      class_name: 'User', foreign_key: 'id'

  has_many :members,       class_name: 'Team::Member', dependent: :destroy
  has_many :member_roles,  class_name: 'Team::Member::Role', dependent: :destroy

  has_many :projects, class_name: 'Project', dependent: :destroy

  validates :name, :creator_id, :admin_id, :presence => true

end
