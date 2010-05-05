class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  helper :all # include all helpers, all the time
  
  before_filter :authenticate_user!
end
