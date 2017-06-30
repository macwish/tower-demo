class User < ApplicationRecord

  has_many :created_teams,   class_name: 'Team', foreign_key: 'creator_id', dependent: :destroy
  has_many :admined_teams,   class_name: 'Team', foreign_key: 'admin_id', dependent: :destroy

  has_many :team_members,    class_name: 'Team::Member', dependent: :destroy
  has_many :project_members, class_name: 'Project::Member', dependent: :destroy
  has_many :project_todos,   class_name: 'Project::Todo', foreign_key: 'assigned_to_member_id', dependent: :destroy

  has_many :comments,        dependent: :destroy
  has_many :events,          dependent: :destroy
  has_many :auths,           dependent: :destroy

  validates :email, :password, :name, :status, :presence => true
  validates :email, uniqueness: true

  # name for display
  def display_name
    name
  end

  def avatar
    return @avatar if @avatar.present?
    @avatar = "/static/images/avatar/default-#{self.id % 4}.png"
  end

  def projects(conditions = {})
    members = self.project_members
    project_ids = members.map do |member|
      member.project_id
    end
    return nil if project_ids.blank?
    project_ids = project_ids || []
    conditions = conditions || {}
    init_cond = {
      id: [project_ids],
      removed: false, 
    }
    conditions.update(init_cond)

    return Project.where(conditions)
  end
  
  # for ActionCable

  def connected
    puts 'user connected'
  end

  def disconnected
    puts 'user disconnected'
  end

  def joined_channel(channel_token)
    puts "user joined_channel: #{channel_token}"
  end

  def leave_channel(channel_token)
    puts "user leave_channel: #{channel_token}"
  end

end
