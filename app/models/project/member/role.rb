class Project::Member::Role < ProjectBase

  self.inheritance_column = nil
  
  enum type: {
    'unset'               => 0,
    'frontend_developer'  => 1,
    'backend_developer'   => 2,
    'ui_designer'         => 3,
    'project_manager'     => 4,
  }
  
  belongs_to :member, class_name: 'Project::Member'

  has_many :accesses, as: :accessrelated,  dependent: :destroy

  validates :member_id, :type, :presence => true

  validates :type, inclusion: types.keys

  def project
    return nil if member.nil?
    member.project
  end

  def name
    return type.to_s
  end

end
