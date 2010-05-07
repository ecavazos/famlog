require "famlog/controllers"

class MessagesController < ApplicationController
  include Famlog::Controllers::MessageMixin

  def index
    case params[:tab]
    when 'today' then

      predicate =<<JS
        function () {
          var now = new Date(),
              day = now.getDate(),
              mon = now.getMonth(),
              yr  = now.getFullYear();

          return this.is_event
          && this.start_date >= new Date(yr, mon, day)
          && this.start_date < new Date(yr, mon, day + 1)
          || (this.start_date <= new Date(yr, mon, day)
          && this.end_date >= new Date(yr, mon, day + 1));
        }
JS
      @messages = Message.where(predicate)
        .order_by([:start_date, :desc]).limit(20)
    when 'forecast' then

      predicate =<<JS
        function () {
          var now = new Date(),
              day = now.getDate(),
              mon = now.getMonth(),
              yr  = now.getFullYear();

          return this.is_event
          && this.start_date >= new Date(yr, mon, day)
          && this.start_date <  new Date(yr, mon, day + 5)
          || (this.end_date >= new Date(yr, mon, day)
          && this.end_date < new Date(yr, mon, day + 5));
        }
JS
      @messages = Message.where(predicate)
        .order_by([:start_date, :asc]).limit(20)
    when 'history'
      @messages = Message.where(:created_at.lt => Date.today.to_time.getutc)
        .order_by([:created_at, :desc]).limit(20)
    else
      @messages = Message.criteria
        .order_by([[:created_at, :desc]]).limit(20)
    end

    render :index, :layout => false
  end

  private

  def set_user
    @message.set_user current_user
    @message.is_event = false
  end
end
