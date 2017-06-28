class EventsController < ApplicationController

  # before_action :only => [:index] do 
  #   set_default_response_format(:event)
  # end

  def index
    @title = "Events"

    count = params[:count]
    count = (1..100).include?(count) ? count : 50

    @events = Event.order(created_at: :desc).limit(count)
  end

end
