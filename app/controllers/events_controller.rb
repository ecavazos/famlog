class EventsController < ApplicationController
  include Famlog::Controllers::MessageMixin
  before_filter :require_user

  private

  def set_user
    @message.set_user current_user
    @message.is_event = true
  end
end
