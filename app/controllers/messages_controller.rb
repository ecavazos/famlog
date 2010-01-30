class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])

    @ecni = User.first(:username => "ecni")
    @message.user = @ecni
    @message.username = @ecni.username

    if @message.save
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])

    @ecni = User.first(:username => "ecni")
    @message.user = @ecni
    @message.username = @ecni.username

    if @message.update_attributes(params[:message])
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  def destroy
    @message = Message.find(params[:id]).destroy
    redirect_to root_url
  end
end
