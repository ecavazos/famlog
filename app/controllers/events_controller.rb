class EventsController < ApplicationController
  include Famlog::Controllers::MessageMixin

  private

  def set_user
    @ecni = User.first(:conditions => { :username => "ecni" })
    @message.set_user @ecni
    @message.is_event = true
  end
end
