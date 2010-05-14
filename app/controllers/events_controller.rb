require 'lib/famlog/datetime_parser'

class EventsController < ApplicationController
  include Famlog::Controllers::MessageMixin

  private

  def before_save(params)
    @message.start = Famlog::DateTimeParser.parse(params[:s_date], params[:s_time])
    @message.end   = Famlog::DateTimeParser.parse(params[:e_date], params[:e_time])

    @message.is_event = true
  end
end
