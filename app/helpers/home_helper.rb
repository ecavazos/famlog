module HomeHelper
  def today
    Date.today.strftime("%A, %B %d, %Y")
  end

  def to_css(val)
    val.downcase.gsub(" ", "-") unless val.nil?
  end

  def edit_link(message)
    return unless current_user.owns?(message)
    link_to "Edit", eval("edit_#{message.type_name.downcase}_path(message)")
  end

  def destroy_link(message)
    return unless current_user.owns?(message)
    link_to "Del", message_path(message), :method => :delete
  end

  def reply_count(message)
    count = message.replies.count

    return if count == 0
    return "#{count} reply" if count == 1

    "#{count} replies"
  end

  def today_label
    count = Message.today_count
    return 'Today' if count == 0
    "Today (#{count})"
  end

  def forecast_label
    count = Message.forecast_count
    return 'Forecast' if count == 0
    "Forecast (#{count})"
  end
end
