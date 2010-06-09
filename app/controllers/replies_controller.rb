class RepliesController < ApplicationController
  layout 'no_tabs'

  before_filter do
    @message = Message.find(params[:message_id])
  end

  def new
  end

  def create
    params[:reply][:user] = current_user # add user to hash
    reply = @message.replies.build(params[:reply])

    Notifier.message_reply_email(reply).deliver if reply.save

    redirect_to :action => :new
  end

  def destroy
    reply = @message.replies.find(params[:id])

    if current_user.owns?(reply)
      reply.destroy
      redirect_to :action => :new
    else
      redirect_to :root
    end
  end
end
