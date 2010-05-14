require "famlog/controllers"

class MessagesController < ApplicationController
  include Famlog::Controllers::MessageMixin

  def index
    @messages = Message.by_tab params[:tab]
    render :index, :layout => false
  end
end
