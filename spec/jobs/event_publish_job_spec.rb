require 'rails_helper'

RSpec.describe EventPublishJob, type: :job do
  
  fixtures :all

  describe "#perform_later" do
    it "enqueue an event" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        user = users(:user_1)
        ApplicationRecord.current_user = user
        Event.create!(
          type: 1,    # 'feed'
          user_id: user.id,
          action: 1,  # 'created'
          target: 'Project::Todo',
          time: Time.now.to_i,
          info: nil,
          eventrelated_type: 'Project::Todo',
          eventrelated_id: 1,
          originrelated_type: 'Project',
          originrelated_id: 1
        )
      }.to have_enqueued_job
    end
  end

end
