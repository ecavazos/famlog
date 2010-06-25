module Famlog::MessageQueries
  module JS
    def default_js
      <<JS
        function () {
          var now = new Date(),
              day = now.getDate(),
              mon = now.getMonth(),
              yr  = now.getFullYear();

          return this.start_at >= new Date(yr, mon, day)
          || this.end_at >= new Date(yr, mon, day)
          || (this.created_at >= new Date(yr, mon, day - 7)
              && this.is_event == false);
        }
JS
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

    def all_messages_for_month_js(sy, sm, ey, em)
      <<JS
        function () {
          var start = new Date(#{sy}, #{sm - 1}, 1),
              end   = new Date(#{ey}, #{em - 1}, 1);

          return !this.is_event && this.created_at >= start && this.created_at < end
        }
JS
    end

    def all_events_for_month_js(year, month)
      <<JS
        function () {
          var start = new Date(#{year}, #{month - 1}, 1),
              end   = new Date(#{year}, #{month}, 1);

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

