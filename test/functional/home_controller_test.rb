require "test_helper"

class HomeControllerTest < ActionController::TestCase

  setup do
    @controller.expects(:current_user)
    @controller.expects(:authenticate_user!)
  end

  context "index" do
    setup do
      get :index
    end

    should respond_with :success
    should assign_to :messages
  end

  context 'help' do
    setup do
      get :help
    end

    should respond_with :success
  end
end
