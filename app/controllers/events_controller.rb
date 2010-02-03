class EventsController < ApplicationController
  def new
    @message = Message.new
    render :layout => "post"
  end
end
