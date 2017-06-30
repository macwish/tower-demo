require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  
  render_views true
  fixtures :all

  describe 'GET #list' do
    it 'should responds project list with 200 status' do
      get :list
      expect(response).to be_success
      expect(response.body).to have_link('project_1_1', :href => '/projects/1')
      expect(response.body).to have_link('project_1_2', :href => '/projects/2')
    end
  end

  describe 'GET #show' do
    it 'should responds project info with 200 status' do
      project = projects(:project_1_1)
      get :show, params: { id: project.id }
      expect(response).to be_success
      expect(response.body).to have_title("Project/Show - #{project.name}")
    end
  end

end
