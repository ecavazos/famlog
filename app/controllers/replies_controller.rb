class RepliesController < ApplicationController
  layout 'no_tabs'

  def new
    @message = Message.find(params[:message_id])
  end

  def create
    @message = Message.find(params[:message_id])
    params[:reply][:user] = current_user # add user to hash
    reply = @message.replies.create(params[:reply])

    # TODO: need to only do this when reply is valid and saved successfully
    MessageMailer.message_reply_email(reply).deliver

    redirect_to :action => :new
  end
end
