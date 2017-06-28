class Project::TodoList < ProjectBase

  belongs_to :project
  
  has_many :todos, class_name: 'Project::Todo', dependent: :destroy

  validates :project_id, :name, :presence => true

end
