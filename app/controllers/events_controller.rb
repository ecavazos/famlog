class EventsController < ApplicationController
  include Famlog::Controllers::MessageMixin

  private

  def set_user
    @message.set_user current_user
    @message.is_event = true
  end
end
