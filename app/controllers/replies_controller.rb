class RepliesController < ApplicationController
  layout 'no_tabs'

  def new
    @message = Message.find(params[:message_id])
  end

  def create
    @message = Message.find(params[:message_id])
    params[:reply][:user] = current_user # add user to hash
    reply = @message.replies.build(params[:reply])

    MessageMailer.message_reply_email(reply).deliver if reply.save

    redirect_to :action => :new
  end
end
