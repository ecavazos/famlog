require 'famlog/message_queries/js'

module Famlog
  module MessageQueries
    include JS

    def by_tab(tab)
      case tab.to_s
      when 'today' then
        where(today).order_by([:start_at, :desc])
      when 'forecast' then
        where(forecast).order_by([:start_at, :asc])
      else
        where(home).order_by([:created_at, :desc])
      end
    end

    def by_month(year, month, type, user)
      query = nil
      range = {
        :sy => year,
        :sm => month,
        :ey => (month == 12)? year + 1 : year,
        :em => (month == 12)? 1 : month + 1
      }

      where(send("#{type.downcase}s_by_month", range, user))
        .order_by([:created_at, :desc])
    end

  end
end
