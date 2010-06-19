require 'test_helper'
require 'functional_helpers'

class MessagesControllerTest < ActionController::TestCase
  include FunctionalHelpers

  setup do
    authenticate_user_mock
  end

  context 'new' do
    setup { get :new }

    should respond_with :success
    should render_template 'new'
    # should render_with_layout 'post'
    should 'assign to message' do
      # shoulda bug in rails 3
      assert_not_nil assigns(:message)
    end
  end

  context 'create' do
    setup do
      @params = { 'title' => 'foo' }
    end

    context 'when successful' do
      setup do
        Message.any_instance.stubs(:save).returns(true)
        post :create, :message => @params
      end

      should 'assign to message' do
        assert_not_nil assigns(:message)
      end

      should 'set the current user on new message' do
        assert_equal @user, assigns(:message).user
      end

      should 'not be an event' do
        assert !assigns(:message).is_event?
      end

      should 'send out an email notifying family members of a new message' do
        msg = Mail::Message.new
        msg.expects(:deliver)
        Notifier.expects(:create_message_email).returns(msg)
      end

      should respond_with :redirect
      should redirect_to('root') { root_path }
    end

    context 'when failure' do
      setup do
        Message.any_instance.stubs(:save).returns(false)
        post :create, :message => @params
      end

      should respond_with :success

      should 'render new' do
        assert_template 'new'
      end
    end
  end

  context 'edit' do
    setup do
      @message = Factory.build(:message)
      @message.user = @user
      Message.expects(:find).with(2).returns(@message)
      get :edit, { :id => 2 }
    end

    should respond_with :success
    should render_template 'edit'
    # should render_with_layout 'post'
    should 'assign to message' do
      assert_not_nil assigns(:message)
    end
  end

  context 'update' do
    setup do
      @params = { 'title' => 'bar' }
      @message = Factory.build(:message)
      @message.user = @user
      Message.expects(:find).with(4).returns(@message)
    end

    context 'when successful' do
      setup do
        @message.expects(:update_attributes).with(@params).returns(true)
        put :update, :id => 4, :message => @params
      end

      should 'assign to message' do
        assert_not_nil assigns(:message)
      end

      should 'not be an event' do
        assert !assigns(:message).is_event?
      end

      should 'send out an email notifying family members of an updated message' do
        msg = Mail::Message.new
        msg.expects(:deliver)
        Notifier.expects(:update_message_email).returns(msg)
      end

      should respond_with :redirect
      should redirect_to('root') { root_path }
    end

    context 'when failure' do
      setup do
        @message.expects(:update_attributes).with(@params).returns(false)
        put :update, :id => 4, :message => @params
      end

      should respond_with :success

      should 'render edit' do
        assert_template 'edit'
      end

      should 'not send an email when message is not valid' do
#        Notifier.expects(:update_message_email).never
      end
    end
  end

  context 'destroy' do
    setup do
      @message = Factory.build(:message)
      @message.user = @user
      Message.expects(:find).with(4).returns(@message)
      delete :destroy, :id => 4
    end
    should redirect_to('root') { root_path }
  end
end
