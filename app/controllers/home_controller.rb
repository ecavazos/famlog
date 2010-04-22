class HomeController < ApplicationController
  before_filter :require_user

  def index
    @messages = Message.criteria.order_by([[:created_at, :desc]])
  end

end
