class MessagesController < MessagesControllerBase

  before_filter :find_message_and_verify_ownership, :except => [:index, :new, :create]

  def index
    if params[:tab] == 'search'
      render :search, :layout => false
      return
    end

    if params['search-phrase']
      search = params['search-phrase']
      @messages = Message.all(:conditions =>
                            { :message => /#{search}/ }).limit(20)
    else
      @messages = Message.by_tab(params[:tab]).limit(20)
    end

    render :index, :layout => false
  end
end
