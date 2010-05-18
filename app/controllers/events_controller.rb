require 'lib/famlog/controllers/messages'
require 'lib/famlog/datetime_parser'

class EventsController < ApplicationController
  include Famlog::Controllers::Messages

  private

  def before_save(params)
    @message.start_at = Famlog::DateTimeParser.parse(params[:s_date], params[:s_time])
    @message.end_at   = Famlog::DateTimeParser.parse(params[:e_date], params[:e_time])

    @message.is_event = true
  end
end
