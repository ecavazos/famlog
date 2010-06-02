class RepliesController < ApplicationController
  layout 'no_tabs'

  def new
    @message = Message.find(params[:message_id])
  end

  def create
    @message = Message.find(params[:message_id])
    params[:reply][:user] = current_user # add user to hash
    @message.replies.create(params[:reply])
    redirect_to :action => :new
  end
end
