module ApplicationConcern
  
  private

    def authenticate_user!(*args)
      puts "authenticate_user: #{args}, @current_user: #{@current_user}"
      
      return true if not @current_user.nil?
      @current_user = User.find(1)
    end

    def set_default_response_format(resp_format = :html)
      if not request.format.to_s.start_with?('application/json')
        format = params[:format]
        if format
          request.format = format
        else
          request.format = resp_format
        end
      end
    end

end
