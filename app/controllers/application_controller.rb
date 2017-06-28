class ApplicationController < ActionController::Base

  include ApplicationConcern
  
  attr_reader :current_user

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protect_from_forgery with: :exception

  before_action :authenticate_user!

  private

    def authenticate_user!(*args)      
      return true if not @current_user.nil?
      
      ## just for demo

      # ssid = cookies[:ssid]
      ssid = 'my_ssid'

      auth = Auth.find_by_ssid(ssid)
      @current_user = auth.user
      
      ApplicationRecord.current_user = @current_user

      permission_denied if current_user.nil?
      return true
    end

    def bad_request
      @title = '400'
      render :file => 'public/400.html', :status => 400, :layout => true
    end

    def permission_denied
      @title = '401'
      render :file => "public/401.html", :status => 401, :layout => true
    end

    def not_found
      @title = '404'
      render :file => 'public/404.html', :status => 404, :layout => true
    end

    def server_error
      @title = '500'
      render :file => 'public/500.html', :status => 500, :layout => true
    end
end
