class HomeController < ApplicationController

  def index
    @messages = Message.by_tab(:home)
  end

  def help
    render :layout => 'no_tabs'
  end

end
