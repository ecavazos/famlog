require 'lib/famlog/message_query'

class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Famlog::MessageQuery

  field :title # events have titles but messages do not
  field :message

  # TODO: these properties should be Dates but due to
  # this bug - http://github.com/durran/mongoid/issues#issue/53
  # I've made DateTimes as a workaround
  field :start_at, :type => DateTime
  field :end_at, :type => DateTime

  field :is_event, :type => Boolean, :default => false
  field :importance, :default => Importance::LOW

  # relationships
  belongs_to_related :user

  def type_name
    is_event ? "Event" : "Message"
  end

  def end_date?
    is_event? && end_at && start_at && (start_at < end_at)
  end

  def start_date_display
    date_display :start
  end

  def start_time_display
    time_display :start
  end

  def end_date_display
    date_display :end
  end

  def end_time_display
    time_display :end
  end

  def date_display(prop)
    send("#{prop}_at").to_time.getutc.strftime("%m/%d/%Y") if send("#{prop}_at")
  end

  def time_display(prop)
    send("#{prop}_at").to_time.getutc.strftime("%l:%M %p").strip.downcase if send("#{prop}_at")
  end
end
