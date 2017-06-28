class EventPublishJob < ApplicationJob

  include ChannelsConstants

  Channel_Token = ChannelsConstants::PushChannelToken
  
  queue_as :default

  def perform(event)
    logger.debug "[Job][Event] did recv job. event: #{event.inspect}"

    ActionCable.server.broadcast(
      Channel_Token, 
      {
        type: event.class.name,
        
        id: event.id,
        action: event.action,
        content: render_event(event)
      }
    )
  end

  private

  def render_event(event)
    EventsController.render partial: 'events/event', locals: {event: event}
  end

end
