require 'rails_helper'

RSpec.describe TeamsController, type: :controller do

  render_views true
  fixtures :all

  describe 'GET #list' do
    it 'should responds team list with 200 status' do
      get :list
      expect(response).to be_success
      expect(response.body).to have_link('team_1', :href => '/teams/1')
    end
  end

  describe 'GET #show' do
    it 'should responds team info with 200 status' do
      team = teams(:team_1)
      get :show, params: { id: team.id }
      expect(response).to be_success
      expect(response.body).to have_title("Team/Show - #{team.name}")
    end
  end

end
