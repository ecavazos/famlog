module Famlog
  module MessageQuery
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def by_tab(tab)
        case tab.to_s
        when 'today' then
          where(event_is_today_js)
            .order_by([:start_at, :desc])
        when 'forecast' then
          where(event_is_this_week_js)
            .order_by([:start_at, :asc])
        when 'history'
          where(:created_at.lt => Date.today.to_time.getutc)
            .order_by([:created_at, :desc])
        else
          all.order_by([:created_at, :desc])
        end
      end

      def by_month(year, month, type)
        year  = year.to_i
        month = month.to_i
        query = nil

        if type.downcase == 'message' then
          ey = (month == 12)?  year + 1 : year
          em = (month == 12)?  1 : month + 1

          query = criteria.and(:created_at.gte => Time.new(year, month, 1))
            .and(:created_at.lt => Time.new(ey, em, 1))
            .and(:is_event => false)
        else
          query = where(all_events_for_month_js(year, month - 1))
        end

          query.order_by([:created_at, :desc])
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

      def all_events_for_month_js(year, month)
        <<JS
          function () {
            var start = new Date(#{year}, #{month}, 1),
                end   = new Date(#{year}, #{month + 1}, 1);

            return this.is_event
            && this.start_at >= start
            && this.start_at < end
            || (this.end_at >= start
            && this.end_at < end);
          }
JS
      end
    end

  end
end
