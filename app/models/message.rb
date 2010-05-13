class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title # events have titles but messages do not
  field :message

  # TODO: these properties should be Dates but due to
  # this bug - http://github.com/durran/mongoid/issues#issue/53
  # I've made DateTimes as a workaround
  field :start_at, :type => DateTime
  field :end_at, :type => DateTime

  field :is_event, :type => Boolean, :default => false
  field :importance, :default => Importance::LOW

  field :user_id
  field :username

  # relationships
  belongs_to_related :user

  def set_user(user)
    self.user = user
    self.username = user.username
  end

  def type_name
    is_event ? "Event" : "Message"
  end

  def end_date?
    (is_event? && end_at) && (end_at > start_at)
  end

  def start_time_display
    start_at.strftime("%m/%d/%Y") if start_at
  end

  def start_time_display
    start_at.strftime("%l:%M%p") if start_at
  end

  def end_date_display
    end_at.strftime("%m/%d/%Y") if end_at
  end

  def end_time_display
    end_at.strftime("%l:%M%p") if end_at
  end

  class << self
    def by_tab(tab)
      case tab
      when 'today' then
        where(event_is_today_js)
          .order_by([:start_at, :desc]).limit(20)
      when 'forecast' then
        where(event_is_this_week_js)
          .order_by([:start_at, :asc]).limit(20)
      when 'history'
        where(:created_at.lt => Date.today.to_time.getutc)
          .order_by([:created_at, :desc]).limit(20)
      else
        all.order_by([[:created_at, :desc]]).limit(20)
      end
    end

    def event_is_today_js
      <<JS
        function () {
          var now = new Date(),
              day = now.getDate(),
              mon = now.getMonth(),
              yr  = now.getFullYear();

          return this.is_event
          && this.start_at >= new Date(yr, mon, day)
          && this.start_at < new Date(yr, mon, day + 1)
          || (this.start_at <= new Date(yr, mon, day)
          && this.end_at >= new Date(yr, mon, day + 1));
        }
JS
    end

    def event_is_this_week_js
      <<JS
        function () {
          var now = new Date(),
              day = now.getDate(),
              mon = now.getMonth(),
              yr  = now.getFullYear();

          return this.is_event
          && this.start_at >= new Date(yr, mon, day)
          && this.start_at <  new Date(yr, mon, day + 5)
          || (this.end_at >= new Date(yr, mon, day)
          && this.end_at < new Date(yr, mon, day + 5));
        }
JS
    end

  end
end
