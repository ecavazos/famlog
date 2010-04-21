class HomeController < ApplicationController
  def index
    puts "blah: #{current_user}"
    @messages = Message.criteria.order_by([[:created_at, :desc]])
  end

end
