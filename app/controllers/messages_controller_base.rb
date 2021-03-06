class MessagesControllerBase < ApplicationController
  layout 'no_tabs'

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    @message.user = current_user
    before_save(params)

    if @message.save
      Notifier.create_message_email(@message).deliver
      redirect_to :root
    else
      render :action => :new
    end
  end

  def edit
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
    redirect_to root_url unless current_user.owns?(@message)
  end

  def before_save(params)
  end

end
