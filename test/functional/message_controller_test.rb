require "test_helper"

class MessagesControllerTest < ActionController::TestCase

  setup do
    # stub rails_warden helper method
    ApplicationHelper.class_eval do
      def current_user
        Factory.build(:user)
      end
    end

    @controller.expects(:require_user)
  end

  test "should get new" do
    get :new
    assert_response :success
  end
end
