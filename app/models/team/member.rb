class Team::Member < ApplicationRecord

  belongs_to :team
  belongs_to :user

  has_many :roles, class_name: 'Team::Member::Role', dependent: :destroy

  validates :team_id, :user_id, :presence => true

end
