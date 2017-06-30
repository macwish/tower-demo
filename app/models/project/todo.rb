class Project::Todo < ProjectBase

  include TodoConcerns
  include EventrelatedProtocol

  belongs_to :todo_list, class_name: 'Project::TodoList'

  has_many :todo_items, class_name: 'Project::TodoItem', dependent: :destroy
  has_many :comments, as: :commentable,  dependent: :destroy
  has_many :related_events, class_name: 'Event', as: :eventrelated, dependent: :destroy

  belongs_to :assigned_to_member, class_name: 'User', optional: true

  validates :todo_list_id, :content, :presence => true

  # model-action's callbacks

  after_create  :did_create
  after_destroy :did_destroy
  after_update  :did_update

  after_initialize :init

  def init
    self.completed = false if (self.has_attribute? :completed) && self.completed.nil?
    self.trashed   = false if (self.has_attribute? :trashed) && self.trashed.nil?

    # self.string ||= 'foo'  # will set the default value only if it's nil
    # self.number ||= 0.0 if self.has_attribute? :number
    # self.bool_field = true if (self.has_attribute? :bool_value) && self.bool_field.nil?
  end

  # ProjectBase

  def project
    return nil if todo_list.nil?
    todo_list.project
  end

  # EventrelatedProtocol

  def self.self_description
    I18n.t(self.name)
  end
  
  def event_target
    self
  end

  def event_title
    title
  end

  # CommentableProtocol

  def comment_title
    title
  end  

  # 

  def title
    content[0..20]
  end

  def completed_status
    completed ? 'Yes' : '-'
  end

  def trashed_status
    trashed ? 'Yes' : '-'
  end

end
