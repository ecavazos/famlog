module FunctionalHelpers
  def authenticate_user_mock
    # TODO: I want this to only be called once per
    # test fixture but currently it's called for every test
    @current_user = Factory.build(:user)
    @current_user.username = 'chum chum'
    @controller.stubs(:current_user).returns(@current_user)
    @controller.expects(:authenticate_user!)
  end

  def mock_mailer(message_name)
    msg = Mail::Message.new
    msg.expects(:deliver)
    Notifier.expects(message_name.to_sym).returns(msg)
  end
end
