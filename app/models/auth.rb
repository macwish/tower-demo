class Auth < ApplicationRecord

  belongs_to :user

  validates :user_id, :token, :presence => true

  def self.find_by_ssid(ssid)

    ## just for demo
    
    # token = session[:ssid][:token]
    token = 'access_token_10'

    return Auth.find_by(token: token)
  end

end
