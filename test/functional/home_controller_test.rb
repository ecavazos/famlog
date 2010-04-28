require "test_helper"

class HomeControllerTest < ActionController::TestCase
  test "should get index" do
    Message.stubs(:find).returns([Factory.build(:message)])
    #get :index
    #assert_response :success
  end

#  context "Index" do
#    setup do
#      get :index
#    end
#
#    should_respond_with :success
#  end
end
