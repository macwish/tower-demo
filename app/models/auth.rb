class Auth < ApplicationRecord

  belongs_to :user

  validates :user_id, :token, :presence => true
  validates :token, uniqueness: { scope: :user_id }

  def self.find_by_ssid(ssid)

    ## just for demo
    
    # token = session[:ssid][:token]
    token = 'user1_access_token_1'

    return Auth.find_by(token: token)
  end

end
