module ApplicationHelper
  def format_datetime(datetime)
    return unless datetime
    datetime.getutc.strftime("%m/%d/%Y at %l:%M %p").gsub('  ', ' ')
  end

  def event_info(message)
    return unless message.is_event?

    haml_tag('p.event-info') do
      haml_concat "#{format_datetime(message.start_at)}"

      if message.end_date?
        haml_concat "to #{format_datetime(message.end_at)}"
      end
    end
  end

  def rails_msg(type)
    type = type.to_sym
    unless type == :alert || type == :notice
      raise ArgumentError, 'Can only handle alert and notice messages.'
    end

    return '' if send(type).blank?

    capture_haml do
      haml_tag("##{type}") do
        haml_concat send(type)
      end
    end
  end
end
