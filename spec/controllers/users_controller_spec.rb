require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  render_views true
  fixtures :users, :auths

  before do
    # 
  end

  describe 'GET #profile' do
    it 'should responds user profile with 200 status' do
      current_user = users(:user_1)
      get :profile
      expect(response).to be_success
      expect(response.body).to include(current_user.email)
      expect(response.body).to include(current_user.name)
    end
  end

  describe 'GET #show' do
    it 'should responds user info with 200 status' do
      user = users(:user_2)
      get :show, params: { id: user.id }
      expect(response).to be_success
      expect(response.body).to include(user.email)
      expect(response.body).to include(user.name)
    end
  end

end
