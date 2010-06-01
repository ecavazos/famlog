require 'lib/famlog/controllers/messages'

class MessagesController < ApplicationController
  include Famlog::Controllers::Messages

  before_filter :find_message_and_verify_ownership, :except => [:new, :create]

  def index
    @messages = Message.by_tab params[:tab]
    render :index, :layout => false
  end
end
