class Project::TodoItem < ProjectBase

  belongs_to :todo, class_name: 'Project::Todo'

  validates :todo_id, :description, :presence => true

  def project
    return nil if todo.nil?
    todo.project
  end

end
