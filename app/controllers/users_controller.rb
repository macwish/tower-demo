class UsersController < ApplicationController

  before_action :set_user, only: [:show]

  def profile
    @user = current_user
  end

  def show
    @title = "User/Show - #{@user.name}"
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

end