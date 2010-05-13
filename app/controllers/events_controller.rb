require 'lib/famlog/datetime_parser'

class EventsController < ApplicationController
  include Famlog::Controllers::MessageMixin

  private

  def set_user
    @message.set_user current_user
    @message.is_event = true
  end

  def before_save(params)
    puts 'monkey tits'
    @message.start_date = Famlog::DateTimeParser.parse(params[:s_date], params[:s_time])
    @message.end_date = Famlog::DateTimeParser.parse(params[:e_date], params[:e_time])
  end
end
