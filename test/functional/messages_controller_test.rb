require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  setup do
    @user = Factory.build(:user)
    @user.username = 'chum chum'
    @controller.stubs(:current_user).returns(@user)
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

      should 'not be an event' do
        assert !assigns(:message).is_event?
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
      @message = Factory.build(:message)
      @message.user = @user
      Message.expects(:find).with(2).returns(@message)
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
      @message.user = @user
      Message.expects(:find).with(4).returns(@message)
      delete :destroy, :id => 4
    end
    should_redirect_to('root') { root_path }
  end
end
