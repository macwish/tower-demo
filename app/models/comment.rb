class Comment < ApplicationRecord

  include CommentConcerns
  include EventrelatedProtocol

  belongs_to :commentable, polymorphic: true, optional: true
  belongs_to :user

  validates :content, :user_id, :presence => true

  # model-action's callbacks

  after_create  :did_create

  after_initialize :init

  def init
    self.status ||= 0.0 if self.has_attribute? :status
  end

  # EventrelatedProtocol

  def self.self_description
    I18n.t(self.name)
  end

  def event_target
    commentable
  end
  
  def event_title
    commentable.comment_title
  end

  # 

  def creation_time
    ctime = read_attribute(:created_at)
    ctime.strftime("%m-%d %R")
  end

end
