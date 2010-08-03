class MembersController < ApplicationController
  layout 'no_tabs'

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.family = current_user.family
    @user.password = '1234'
    @user.password_confirmation = '1234'

    if @user.save
      redirect_to :family
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.family == current_user.family
      @user.destroy
    end

    redirect_to :family
  end
end
