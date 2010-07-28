module FunctionalHelpers
  def authenticate_user_mock
    @user = Factory.build(:user)
    @user.username = 'chum chum'
    @controller.stubs(:current_user).returns(@user)
    @controller.expects(:authenticate_user!)
  end

  def mock_mailer(message_name)
    msg = Mail::Message.new
    msg.expects(:deliver)
    Notifier.expects(message_name.to_sym).returns(msg)
  end
end
