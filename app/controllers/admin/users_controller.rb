class Admin::UsersController < ApplicationController
  before_action :authorized


private

  def authorized
    unless current_user && current_user.admin?
      flash[:alert] = "You are not an admin."
      redirect_to root_path
    end
  end

end
