class PushChannel < ApplicationCable::Channel

  include ChannelsConstants

  Channel_Token = ChannelsConstants::PushChannelToken

  def subscribed
    logger.debug "[AC][Push] subscribed[#{Channel_Token}]. user: [#{current_user.email}##{current_user.display_name}]"
    logger.debug "[AC][Push] params: #{params}"

    client_token = params[:token]
    reject if client_token.nil?

    stream_from Channel_Token
    current_user.joined_channel(Channel_Token)
  end

  def unsubscribed
    logger.debug "[AC][Push] unsubscribed[#{Channel_Token}]. user: [#{current_user.email}##{current_user.display_name}]"

    current_user.leave_channel(Channel_Token)
  end

  # 

  # process the data send from the browser
  def incoming_browser_message(data)
    logger.debug "[AC][Push] data from brower: #{data}"
  end
end
