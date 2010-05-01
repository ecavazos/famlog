module ApplicationHelper

  def show_flash
    html, template = "", "<div id='%s'>%s</div>"

    html += template % ["notice", flash[:notice]] if flash[:notice]
    html += template % ["error", flash[:error]]   if flash[:error]
  end
end
