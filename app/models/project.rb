class Project < ApplicationRecord

  include ProjectAccessConcerns  
  include OriginrelatedProtocol
  include MemberConcerns

  self.inheritance_column = nil

  enum type: {
    'standard' => 0,
    'board'    => 1,
  }

  belongs_to :team

  has_many :members,        class_name: 'Project::Member',       dependent: :destroy
  has_many :member_roles,   class_name: 'Project::Member::Role', dependent: :destroy
  has_many :todo_lists,     class_name: 'Project::TodoList',     dependent: :destroy
  has_many :ralated_events, class_name: 'Event', as: :originrelated, dependent: :destroy

  validates :team_id, :name, :type, :is_private, :status, :presence => true

  validates :type, inclusion: types.keys


  # OriginrelatedProtocol

  def origin
    self
  end
  
  def origin_name
    self.name
  end

end
