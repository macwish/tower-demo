class Project::Member < ApplicationRecord

  belongs_to :project
  belongs_to :user

  has_many :roles, class_name: 'Project::Member::Role', dependent: :destroy

  validates :project_id, :user_id, :presence => true
  validates :user_id, uniqueness: { scope: :project_id }
  
end
