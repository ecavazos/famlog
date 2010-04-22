class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  helper :all # include all helpers, all the time

  private

  def require_user
    unless current_user
      flash[:notice] = "You must be logged in to access that page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      flash[:notice] = "You must be logged out to access that page"
      redirect_to root_url
      return false
    end
  end
end
