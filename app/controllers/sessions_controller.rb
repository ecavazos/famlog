class SessionsController < Devise::SessionsController
  #prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  
  def new
    clean_up_passwords(build_resource)
    render :layout => 'modal'
  end
end
