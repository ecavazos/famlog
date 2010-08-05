require 'test_helper'
require 'functional_helpers'

class RepliesControllerTest < ActionController::TestCase
  include FunctionalHelpers

  setup do
    authenticate_user_mock
    @message = Factory.create(:message)
    @message.user = @current_user
    @message.save
    Message.expects(:find).with(@message.id).returns(@message)
  end

  context 'new' do
    setup do
      get :new, :message_id => @message.id
    end

    should respond_with :success
    should render_template 'new'
    should render_with_layout 'no_tabs'
    should assign_to :message
  end

  context 'create' do
    setup do
      @params = { 'text' => 'foo' }
    end

    context 'when successful' do
      setup do
        mock_mailer :message_reply_email
        post :create, { :message_id => @message.id, :reply => @params }
      end

      should 'create a new reply' do
        assert_equal 1, assigns(:message).replies.length
      end

      should 'set the current user on new reply' do
        assert_equal @current_user, assigns(:message).replies.first.user
      end

      should assign_to :message
      should respond_with :redirect
      should redirect_to('to new action') { new_message_reply_path(@message) }
    end

    context 'when failure' do
      should 'not send an email when reply is not valid' do
        Reply.any_instance.stubs(:save).returns(false)
        Notifier.expects(:message_reply_email).never
        post :create, { :message_id => @message.id, :reply => @params }
      end
    end
  end

  context 'destroy' do
    setup do
      @reply = @message.replies.create(:text => 'blah', :user => @current_user)
    end

    context 'when called by owner' do
      setup do
        @reply.expects(:destroy)
        delete :destroy, :id => @reply.id, :message_id => @message.id
      end

      should assign_to :message
      should respond_with :redirect
      should redirect_to('to new action') { new_message_reply_path(@message) }
    end

    context 'when not called by owner' do
      setup do
        @reply.user = Factory.build(:user)
        @reply.save
        delete :destroy, :id => @reply.id, :message_id => @message.id
      end

      should respond_with :redirect
      should redirect_to('root') { root_path }
    end

  end

end
