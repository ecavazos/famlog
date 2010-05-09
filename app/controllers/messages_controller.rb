require "famlog/controllers"

class MessagesController < ApplicationController
  include Famlog::Controllers::MessageMixin

  def index
    @messages = Message.by_tab params[:tab]
    render :index, :layout => false
  end

  private

  def set_user
    @message.set_user current_user
    @message.is_event = false
  end
end
