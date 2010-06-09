class HomeController < ApplicationController

  def index
    @messages = Message.most_recent.page_one
  end

  def help
    render :layout => 'no_tabs'
  end

end
