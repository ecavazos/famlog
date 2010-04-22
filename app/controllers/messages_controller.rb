require "famlog/controllers"

class MessagesController < ApplicationController
  include Famlog::Controllers::MessageMixin
  before_filter :require_user

  private

  def set_user
    @ecni = User.first(:conditions => { :username => "ecni" })
    @message.set_user @ecni
    @message.is_event = false
  end
end
