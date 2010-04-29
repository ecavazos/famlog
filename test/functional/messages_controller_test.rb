require "test_helper"

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

  test "should get new" do
    get :new
    assert_response :success
    assert_template :new
    assert_not_nil assigns(:message)
  end

  test "should get edit" do
    Message.expects(:find).with(2).returns(Factory.build(:message))
    get :edit, { :id => 2 }
    assert_response :success
    assert_template :edit
    assert_not_nil assigns(:message)
  end

  context "create" do
    should "redirect to root when post to create is successful" do
      post :create
      message = Factory.build(:message)
      message.expects(:set_user).with(@user)
      Message.stubs(:find).returns(message)
      assert_redirected_to root_path
    end

    should "render new when post to create fails" do
      post :create
      message = Factory.build(:message)
      message.expects(:save).returns(false)
      Message.stubs(:find).returns(message)
      assert_response :redirect
      assert_template :new
    end
  end
end
