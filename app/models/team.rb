class Team < ApplicationRecord

  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :admin,   class_name: 'User', foreign_key: 'admin_id'

  has_many :members,   class_name: 'Team::Member', dependent: :destroy
  has_many :projects,  class_name: 'Project', dependent: :destroy

  validates :name, :creator_id, :admin_id, :presence => true

end
