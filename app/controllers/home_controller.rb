class HomeController < ApplicationController
  def index
    @messages = Message.criteria.order_by([[:created_at, :desc]])
  end

end
