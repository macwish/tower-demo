class EventsController < ApplicationController

  def index
    @title = "Events"

    count = params[:count]
    count = (1..100).include?(count) ? count : 50

    @events = Event.order(created_at: :desc).limit(count)
  end

end
