module Famlog
  module MessageQuery
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
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
end
