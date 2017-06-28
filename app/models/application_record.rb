class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  class_attribute :current_user

  # for events
  
  after_commit { 
    if not @events.nil?
      begin
        @events.each do |event|
          event.save!
        end
      rescue Exception => e
        logger.error "save event error: #{e.message}"
      end
      @events = nil
    end
  }

  private

    def new_event(action, origin, eventrelated, info = nil)
      current_user = self.class.current_user  # current_user: null able
      return if current_user.nil?

      @events = @events || []
      @events << Event.new({
        type: 'feed',
        user_id: current_user.id,
        action: action,
        target: self.class.name,
        time: Time.now.to_i,
        info: info,
        eventrelated: eventrelated,
        originrelated: origin
      })
    end

end
