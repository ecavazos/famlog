module HomeHelper
  def today
    Date.today.strftime("%A, %B %d, %Y")
  end

  def created_at(model)
    model.created_at.strftime("%m/%d/%Y at %l:%M%p")
  end

  def to_css(val)
    val.downcase.gsub(" ", "-")
  end
end
