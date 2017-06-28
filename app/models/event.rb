# for db model auto serialize
class EventInfo
  # to Hash instance
  def self.load(json_string)
    begin
      return JSON.parse(json_string, {symbolize_names: true})
    rescue
      # nil input string or not a valid JSON format
    end
    # return new hash as default
    return Hash.new
  end

  # to JSON string (then save to db)
  def self.dump(instance)
    return instance.to_json
  end
end

class Event < ApplicationRecord

  self.inheritance_column = nil

  enum type: {
    'unset'  => 0,
    'feed'   => 1,
    'report' => 2,
  }

  enum action: {
    'unknown'    => 0,

    'created'    => 1,
    'updated'    => 2,
    'removed'    => 3,

    'finished'   => 4,
    'reworked'   => 5,
    'assigned'   => 6,
    'reassigned' => 7,
    'updated_content' => 8,

    'changed_deadline' => 9,

    'commented'  => 10,
  }

  belongs_to :eventrelated, polymorphic: true, optional: true
  belongs_to :originrelated, polymorphic: true, optional: true
  belongs_to :user

  # event.info, null able.
  # if 'info' presented, then it must be a Hash type (JSON.dump able).
  # and should be have a info[:description] value.
  serialize :info, EventInfo

  validates :type, :user_id, :action, :target, :time, :presence => true
  validates :type, inclusion: types.keys
  validates :action, inclusion: actions.keys

  # 

  after_create_commit { 
    if Event.should_push_event?
      EventPublishJob.perform_later(self)
    end
  }

  def self.should_push_event?
    self.current_user.present?
  end

  # 

  def target
    target_string = read_attribute(:target)
    begin
      return target_string.classify.constantize.self_description
    rescue Exception => e
    end
  end

  def action_name
    I18n.t(action)
  end

end


