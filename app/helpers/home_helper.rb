module HomeHelper
  def today
    Date.today.strftime("%A, %B %d, %Y")
  end

  def format_datetime(datetime)
    return unless datetime
    datetime.getutc.strftime("%m/%d/%Y at %l:%M %p").gsub('  ', ' ')
  end

  def to_css(val)
    val.downcase.gsub(" ", "-") unless val.nil?
  end

  def to_edit(message)
    link_to "Edit", eval("edit_#{message.type_name.downcase}_path(message)")
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
end
