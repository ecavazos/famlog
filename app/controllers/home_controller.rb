class HomeController < ApplicationController

  def index
    @messages = Message.all.order_by([[:created_at, :desc]]).limit(20)
  end

  def help
    render :layout => 'post'
  end

end
