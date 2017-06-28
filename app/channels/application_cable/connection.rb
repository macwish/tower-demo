require 'cgi'

module ApplicationCable
  class Connection < ActionCable::Connection::Base

    identified_by :current_user

    def connect
      logger.debug '[AC][Push] a client trying to connect...'
      self.current_user = find_verified_user
      self.current_user.connected()

      logger.debug "[AC][Push] connected. user: #{self.current_user.name}"
      logger.add_tags 'ActionCable', current_user.email + '#' + current_user.display_name
    end

    def disconnect
      logger.debug '[AC][Push] disconnect'
      if not self.current_user.nil?
        logger.debug "[AC][Push] user: #{self.current_user.name}"
        self.current_user.disconnected()
      end
    end

    protected 

      def find_verified_user
        logger.debug '[AC][Push] find_verified_user...'

        ## just for demo
        
        # cookie_string = env['HTTP_COOKIE']
        # cookies = CGI::Cookie::parse(cookie_string)
        # ssid = cookies[:ssid]
        ssid = 'my_ssid'

        auth = Auth.find_by_ssid(ssid)
        return auth.user

        # or
        # reject_unauthorized_connection        
      end

  end
end
