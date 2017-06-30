require 'rails_helper'

RSpec.describe Auth, type: :model do
  
  fixtures :auths

  it 'should responds auth info' do
    auth = Auth.find_by_ssid('a_demo_ssid')
    expect(auth).to be  # to be (not nil or false)
  end

end
