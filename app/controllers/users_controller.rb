class UsersController < ApplicationController
  before_filter :require_user, :except => [:new, :create]

  def new
    @user = User.new
    render :layout => "post"
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      warden.set_user(@user)
      redirect_to :root
    else
      render :action => :new
    end
  end

  def edit
    @user = current_user
    render :layout => "post"
  end
end
