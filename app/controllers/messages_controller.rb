require 'lib/famlog/controllers/messages'

class MessagesController < ApplicationController
  include Famlog::Controllers::Messages

  def index
    @messages = Message.by_tab params[:tab]
    render :index, :layout => false
  end
end
