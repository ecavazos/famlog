require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  setup do
    # stub rails_warden helper method
    @user = Factory.build(:user)
    ApplicationHelper.class_eval do
      def current_user
        @user
      end
    end
    @controller.expects(:current_user).returns(@user)
    @controller.expects(:require_user)
  end

  context 'new' do
    setup { get :new }

    should_respond_with :success
    should_render_template :new
    # should_render_with_layout 'post'
    should 'assign to message' do
      # shoulda bug in rails 3 bug
      assert_not_nil assigns(:message)
    end
  end

  context 'create' do
    setup do
      @params = { :message => { :title => 'Foo' } }
      @message = Factory.build(:message)
      Message.stubs(:find).returns(@message)
      post :create, :post => @params
    end

    context 'when successful' do
      setup do
        @message.expects(:new).with(@params[:message])
        @message.expects(:set_user).with(@user)
      end

      should 'assign to message' do
        assert_not_nil assigns(:message)
      end

      should_respond_with :redirect
      should_redirect_to('root') { root_path }
    end

    context 'when failure' do
      setup do
        @message.expects(:new).with(@params[:message])
        @message.expects(:save).returns(false)
      end

      should_respond_with :redirect

      should 'render new' do
        assert_template :new
      end
    end
  end

  context 'edit' do
    setup do
      get :edit, { :id => 2 }
      Message.expects(:find).with(2).returns(Factory.build(:message))
    end

    should_respond_with :success
    should_render_template :edit
    # should_render_with_layout 'post'
    should 'assign to message' do
      assert_not_nil assigns(:message)
    end
  end

  context 'update' do
    setup do
      @params = { :message => { :title => 'Bar' } }
      @message = Factory.build(:message)
      Message.expects(:find).with(4).returns(@message)
      put :update, {:id => 4, :post => @params}
    end

    context 'when successful' do
      setup do
        @message.expects(:update_attributes).with(@params[:message]).returns(true)
        @message.expects(:set_user).with(@user)
      end

      should 'assign to message' do
        assert_not_nil assigns(:message)
      end

      should_respond_with :redirect
      should_redirect_to('root') { root_path }
    end

  end
end
