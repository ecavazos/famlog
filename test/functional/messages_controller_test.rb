require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  setup do
    # stub rails_warden helper method
    @user = Factory.build(:user)
    ApplicationHelper.class_eval do
      def current_user; @user end
    end
    @controller.expects(:current_user).returns(@user)
    @controller.expects(:authenticate_user!)
  end

  context 'new' do
    setup { get :new }

    should_respond_with :success
    should_render_template 'new'
    # should_render_with_layout 'post'
    should 'assign to message' do
      # shoulda bug in rails 3 bug
      assert_not_nil assigns(:message)
    end
  end

  context 'create' do
    setup do
      @params = { 'title' => 'foo' }
      @message = Factory.build(:message)
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

      should_respond_with :redirect
      should_redirect_to('root') { root_path }
    end

    context 'when failure' do
      setup do
        Message.any_instance.stubs(:save).returns(false)
        post :create, :message => @params
      end

      should_respond_with :success

      should 'render new' do
        assert_template 'new'
      end
    end
  end

  context 'edit' do
    setup do
      Message.expects(:find).with(2).returns(Factory.build(:message))
      get :edit, { :id => 2 }
    end

    should_respond_with :success
    should_render_template 'edit'
    # should_render_with_layout 'post'
    should 'assign to message' do
      assert_not_nil assigns(:message)
    end
  end

  context 'update' do
    setup do
      @params = { 'title' => 'bar' }
      @message = Factory.build(:message)
      Message.expects(:find).with(4).returns(@message)
    end

    context 'when successful' do
      setup do
        @message.expects(:update_attributes).with(@params).returns(true)
        @message.expects(:set_user).with(@user)
        put :update, :id => 4, :message => @params
      end

      should 'assign to message' do
        assert_not_nil assigns(:message)
      end

      should_respond_with :redirect
      should_redirect_to('root') { root_path }
    end

    context 'when failure' do
      setup do
        @message.expects(:update_attributes).with(@params).returns(false)
        put :update, :id => 4, :message => @params
      end

      should_respond_with :success

      should 'render edit' do
        assert_template 'edit'
      end
    end
  end

  context 'destroy' do
    setup do
      @message = Factory.build(:message)
      Message.expects(:find).with(4).returns(@message)
      delete :destroy, :id => 4
    end
    should_redirect_to('root') { root_path }
  end
end
