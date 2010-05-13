class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all # include all helpers, all the time

  before_filter :authenticate_user!

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      'no_tabs'
    else
      'application'
    end
  end
end
