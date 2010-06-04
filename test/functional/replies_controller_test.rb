require 'test_helper'
require 'functional_helpers'

class RepliesControllerTest < ActionController::TestCase
  include FunctionalHelpers

  setup do
    authenticate_user_mock
    @message = Factory.create(:message)
    @message.user = @user
    Message.expects(:find).with(@message.id).returns(@message)
  end

  context 'new' do
    setup do
      get :new, :message_id => @message.id
    end

    should_respond_with :success
    should_render_template 'new'
    # should_render_with_layout 'post'
    should 'assign to message' do
      # shoulda bug in rails 3
      assert_not_nil assigns(:message)
    end
  end

  context 'create' do
    setup do
      @params = { 'text' => 'foo' }
      post :create, { :message_id => @message.id, :reply => @params }
    end

    should 'assign to message' do
      assert_not_nil assigns(:message)
    end

    should 'create a new reply' do
      assert_equal 1, assigns(:message).replies.length
    end

    should 'set the current user on new reply' do
      assert_equal @user, assigns(:message).replies.first.user
    end

    should_respond_with :redirect
    should_redirect_to('new') { new_message_reply_path(@message) }
  end

end
