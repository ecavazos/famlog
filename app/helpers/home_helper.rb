module HomeHelper
  def today
    Date.today.strftime("%A, %B %d, %Y")
  end

  def to_css(val)
    val.downcase.gsub(" ", "-") unless val.nil?
  end

  def to_edit(message)
    return unless message.belongs_to? current_user
    link_to "Edit", eval("edit_#{message.type_name.downcase}_path(message)")
  end
end
