class MessagesController < MessagesControllerBase

  before_filter :find_message_and_verify_ownership, :except => [:index, :new, :create]

  def index
    if params[:tab] == 'search'
      return render :search, :layout => false
    end

    if params[:tab] == 'history'
      return render :history, :layout => false
    end

    if params['search-phrase']
      @messages = Message.search(params['search-phrase'])
    elsif params['month']
      user = current_user if params['mine']
      @messages = Message.by_month(params['year'].to_i, params['month'].to_i, params['type'], user)
    else
      @messages = Message.by_tab(params[:tab]).limit(20)
    end

    render :index, :layout => false
  end
end
