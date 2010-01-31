module HomeHelper
  def today
    Date.today.strftime("%A, %B %d, %Y")
  end

  def created_at(model)
    model.created_at.strftime("%m/%d/%Y at %l:%M%p")
  end

  def importance_to_css(message)
    message.importance.downcase.gsub(" ", "-")
  end
end
