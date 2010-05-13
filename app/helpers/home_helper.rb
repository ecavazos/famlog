module HomeHelper
  def today
    Date.today.strftime("%A, %B %d, %Y")
  end

  def format_datetime(datetime)
    datetime.getutc.strftime("%m/%d/%Y at %l:%M%p") if datetime
  end

  def event_info(message)
    return unless message.is_event?

    haml_tag('p.event-info') do
      haml_concat "#{format_datetime(message.start_at)}"
      return unless message.end_date?
      haml_concat " to #{format_datetime(message.end_at)}"
    end
  end

  def to_css(val)
    val.downcase.gsub(" ", "-") unless val.nil?
  end

  def type_name_to_css(message)
    message.type_name.downcase
  end

  def to_edit(message)
    link_to "Edit", eval("edit_#{message.type_name.downcase}_path(message)")
  end
end
