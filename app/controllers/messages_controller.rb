class MessagesController < MessagesControllerBase

  before_filter :find_message_and_verify_ownership, :except => [:index, :new, :create]

  def index
    @messages = Message.by_tab(params[:tab]).limit(20)
    render :index, :layout => false
  end
end
