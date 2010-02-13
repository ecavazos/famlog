class UsersController < ApplicationController

  def new
    @user = User.new
    render :layout => "post"
  end

  def edit
    @user = current_user
    render :layout => "post"
  end
end
