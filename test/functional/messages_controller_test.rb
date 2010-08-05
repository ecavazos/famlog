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
    should render_with_layout :no_tabs
    should assign_to :message
  end

  context 'create' do
    setup do
      @params = { 'title' => 'foo' }
    end

    context 'when successful' do
      setup do
        Message.any_instance.stubs(:save).returns(true)
        mock_mailer :create_message_email
        post :create, :message => @params
      end

      should 'set the current user on new message' do
        assert_equal @current_user, assigns(:message).user
      end

      should 'not be an event' do
        assert !assigns(:message).is_event?
      end

      should assign_to :message
      should respond_with :redirect
      should redirect_to('root') { root_path }
    end

    context 'when failure' do
      setup do
        Message.any_instance.stubs(:save).returns(false)
        post :create, :message => @params
      end

      should respond_with :success
      should render_template :new
      should render_with_layout :no_tabs
    end
  end

  context 'edit' do
    setup do
      @message = Factory.build(:message)
      @message.user = @current_user
      Message.expects(:find).with(2).returns(@message)
      get :edit, { :id => 2 }
    end

    should respond_with :success
    should render_template :edit
    should render_with_layout :no_tabs
    should assign_to :message
  end

  context 'update' do
    setup do
      @params = { 'title' => 'bar' }
      @message = Factory.build(:message)
      @message.user = @current_user
      Message.expects(:find).with(4).returns(@message)
    end

    context 'when successful' do
      setup do
        @message.expects(:update_attributes).with(@params).returns(true)
        mock_mailer :update_message_email
        put :update, :id => 4, :message => @params
      end

      should 'not be an event' do
        assert !assigns(:message).is_event?
      end

      should assign_to :message
      should respond_with :redirect
      should redirect_to('root') { root_path }
    end

    context 'when failure' do
      setup do
        @message.expects(:update_attributes).with(@params).returns(false)
        Notifier.expects(:update_message_email).never
        put :update, :id => 4, :message => @params
      end

      should respond_with :success
      should render_template :edit
      should render_with_layout :no_tabs
    end
  end

  context 'destroy' do
    setup do
      @message = Factory.build(:message)
      @message.user = @current_user
      Message.expects(:find).with(4).returns(@message)
      delete :destroy, :id => 4
    end
    should redirect_to('root') { root_path }
  end
end
