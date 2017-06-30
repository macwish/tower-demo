require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  render_views true
  fixtures :all

  describe 'GET #index' do
    it 'should responds event list with 200 status' do
      events_count = Event.all.size
      get :index
      expect(response).to be_success
      expect(response.body).to have_css('.event-block', count: events_count)
    end
  end

end
