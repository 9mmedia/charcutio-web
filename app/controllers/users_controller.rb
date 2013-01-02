class UsersController < ApplicationController

  def show
    @user = User.find params[:id]
    redirect_to root_url unless @user
  end
end
