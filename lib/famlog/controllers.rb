module Famlog
  module Controllers
    module MessageMixin

      def new
        @message = Message.new
        render :layout => "post"
      end

      def create
        @message = Message.new(params[:message])
        set_user

        if @message.save
          redirect_to :root
        else
          render :action => :new
        end
      end

      def edit
        find_message
        render :layout => "post"
      end

      def update
        find_message
        set_user

        if @message.update_attributes(params[:message])
          redirect_to :root
        else
          render 'edit'
        end
      end

      def destroy
        find_message.destroy
        redirect_to root_url
      end

      private

      def find_message
        @message = Message.find(params[:id])
      end

    end
  end
end
