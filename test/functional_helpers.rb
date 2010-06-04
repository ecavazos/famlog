module FunctionalHelpers
  def authenticate_user_mock
    @user = Factory.build(:user)
    @user.username = 'chum chum'
    @controller.stubs(:current_user).returns(@user)
    @controller.expects(:authenticate_user!)
  end
end
