module HomeHelper
  def today
    Date.today.strftime("%A, %B %d, %Y")
  end

  def to_css(val)
    val.downcase.gsub(" ", "-") unless val.nil?
  end

  def edit_link(message)
    return unless message.belongs_to? current_user
    link_to "Edit", eval("edit_#{message.type_name.downcase}_path(message)")
  end

  def destroy_link(message)
    return unless message.belongs_to? current_user
    link_to "Delete", message_path(message), :method => :delete
  end

  def reply_count(message)
    count = message.replies.length

    return if count == 0

    if count == 1 then
      return "#{count} reply"
    end
    "#{count} replies"
  end
end
