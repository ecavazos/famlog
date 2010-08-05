require 'test_helper'
require 'functional_helpers'

class MembersControllerTest < ActionController::TestCase
  include FunctionalHelpers

  setup do
    authenticate_user_mock
  end

  context 'new' do
    setup do
      get :new
    end

    should respond_with :success
    should render_template :new
    should render_with_layout :no_tabs
    should assign_to :user
  end

  context 'create' do

    context 'when successful' do
      setup do
        params = Factory.attributes_for(:gank)
        post :create, :user => params
      end

      should respond_with :redirect
      should redirect_to('family') { family_url }
      should assign_to :user
    end

    context 'when failure' do
      setup do
        post :create
      end

      should respond_with :success
      should render_template :new
      should render_with_layout :no_tabs
    end
  end

  context 'destroy' do
    setup do
      @user = Factory.build(:user)
      User.expects(:find).with(7).returns(@user)
    end
    context 'when successful' do
      setup do
        @user.family = @current_user.family
        @user.expects(:destroy)
        delete :destroy, :id => 7
      end

      should redirect_to('family') { family_url }
    end

    context 'when failure' do
      setup do
        @user.expects(:destroy).never
        delete :destroy, :id => 7
      end

      should redirect_to('family') { family_url }
    end
  end
end
