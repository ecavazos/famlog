module HomeHelper
  def today
    Date.today.strftime("%A, %B %d, %Y")
  end

  def created_at(model)
    model.created_at.strftime("%m/%d/%Y at %l:%M%p")
  end

  def to_css(val)
    val.downcase.gsub(" ", "-") unless val.nil?
  end

  def to_edit(message)
    type = message.is_event ? "event" : "message"
    link_to "Edit", eval("edit_#{type}_path(message)")
  end
end
