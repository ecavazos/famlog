require 'famlog/datetime_parser'

class EventsController < MessagesControllerBase
  before_filter :find_message_and_verify_ownership, :except => [:new, :create]

  private

  def before_save(params)
    @message.start_at = Famlog::DateTimeParser.parse(params[:s_date], params[:s_time])
    @message.end_at   = Famlog::DateTimeParser.parse(params[:e_date], params[:e_time])

    @message.is_event = true
  end
end
