module ApplicationCable
  class Channel < ActionCable::Channel::Base

    private

      # identifier: <unused>
      def generate_connection_token(identifier)
        SecureRandom.uuid
      end

  end
end
