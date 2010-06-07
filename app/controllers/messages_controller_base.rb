class MessagesControllerBase < ApplicationController
  def new
    @message = Message.new
    render :layout => "no_tabs"
  end

  def create
    @message = Message.new(params[:message])
    @message.user = current_user
    before_save(params)

    if @message.save
      puts 'save'
      Notifier.create_message_email(@message).deliver
      redirect_to :root
    else
      puts 'fail'
      render :action => :new
    end
  end

  def edit
    render :layout => "no_tabs"
  end

  def update
    @message.user = current_user
    before_save(params)

    if @message.update_attributes(params[:message])
      Notifier.update_message_email(@message).deliver
      redirect_to :root
    else
      render 'edit'
    end
  end

  def destroy
    @message.destroy
    redirect_to root_url
  end

  private

  def find_message_and_verify_ownership
    @message = Message.find(params[:id])
    redirect_to root_url unless @message.belongs_to? current_user
  end

  def before_save(params)
  end

end
