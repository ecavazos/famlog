require 'famlog/message_queries'

class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  extend  Famlog::MessageQueries

  field :title # events have titles but messages do not
  field :message

  # TODO: mongoid/mongodb bug - http://github.com/durran/mongoid/issues#issue/53
  field :start_at, :type => Time
  field :end_at,   :type => Time

  field :is_event, :type => Boolean, :default => false
  field :importance, :default => Importance::LOW

  # relationships
  belongs_to_related :user
  embeds_many :replies

  named_scope :most_recent, :order_by => [[:created_at, :desc]]
  named_scope :page_one, :limit => 20

  class << self
    def today_count
      by_tab(:today).count
    end

    def forecast_count
      by_tab(:forecast).count
    end

    def search(query)
      all(:conditions => { :message => /#{query}/i })
      .limit(20).order_by([:create_at, :desc])
    end
  end

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
