module Famlog::MessageQueries
  module JS
    def home
      <<JS
        function () {
          #{today_vars}

          return this.start_at >= new Date(yr, mon, day)
          || this.end_at >= new Date(yr, mon, day)
          || (this.created_at >= new Date(yr, mon, day - 7)
              && this.is_event == false);
        }
JS
    end

    def today
      <<JS
        function () {
          #{today_vars}

          return this.is_event
          && (this.start_at >= new Date(yr, mon, day)
          && this.start_at < new Date(yr, mon, day + 1))
          || (this.start_at <= new Date(yr, mon, day)
          && this.end_at >= new Date(yr, mon, day + 1));
        }
JS
    end

    def forecast
      <<JS
        function () {
          #{today_vars}

          return this.is_event
          && (this.start_at >= new Date(yr, mon, day)
          && this.start_at <  new Date(yr, mon, day + 5))
          || (this.end_at >= new Date(yr, mon, day)
          && this.end_at < new Date(yr, mon, day + 5));
        }
JS
    end

    def messages_by_month(range, user)
      <<JS
        function () {
          #{month_range(range)}

          return !this.is_event
            && this.created_at >= start
            && this.created_at < end
            #{user_clause(user)};
        }
JS
    end

    def events_by_month(range, user)
      <<JS
        function () {
          #{month_range(range)}

          return this.is_event
            && ((this.start_at >= start && this.start_at < end)
              || (this.end_at >= start && this.end_at < end))
            #{user_clause(user)};
        }
JS
    end

    private

    def user_clause(user)
      "&& this.user_id == '#{user.id}'" if user
    end

    def month_range(range)
      "var start = new Date(#{range[:sy]}, #{range[:sm] - 1}, 1),
           end   = new Date(#{range[:ey]}, #{range[:em] - 1}, 1);"
    end

    def today_vars
      "var now = new Date(),
           day = now.getDate(),
           mon = now.getMonth(),
           yr  = now.getFullYear();"
    end
  end
end

