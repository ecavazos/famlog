require 'test_helper'
require 'functional_helpers'

class FamiliesControllerTest < ActionController::TestCase
  include FunctionalHelpers

  setup do
    authenticate_user_mock
  end

  context 'show' do
    setup do
      get :show
    end

    should respond_with :success
    should render_template :show
    should render_with_layout :no_tabs
    should assign_to :family
  end
end
