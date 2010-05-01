class SessionsController < Devise::SessionsController
  def new
    clean_up_passwords(build_resource)
    render :layout => 'modal'
  end
end
