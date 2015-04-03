class Admin::UsersController < ApplicationController
  before_action :authorized

def index
  @users = User.page(params[:page]).per(1)
end

def destroy
  @users = User.find(params[:id])
  @users.destroy
  redirect_to admin_users_path 
end


private

  def authorized
    unless current_user && current_user.admin?
      flash[:alert] = "You are not an admin."
      redirect_to root_path
    end
  end

end
