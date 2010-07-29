require 'test_helper'

class HomeHelperTest < ActionView::TestCase

  should 'display the current date in a nice format' do
    fake_today = Date.new(2010, 5, 18)
    Date.stubs(:today).returns(fake_today)
    assert_equal 'Tuesday, May 18, 2010', today
  end

  should 'replace spaces with dashes when calling to_css' do
    assert_equal 'foo-bar', to_css('foo bar')
  end

  should 'convert uppercase letters to lowercase when calling to_css' do
    assert_equal 'foo-bar', to_css('FOO-BaR')
  end

  should 'be nil if called with a nil parameter' do
    assert_nil to_css(nil)
  end

  context 'edit link' do
    setup do
      @user = User.create(:username => 'iron man')
      stubs(:current_user).returns(@user)
    end

    should 'create an edit link for a message' do
      message = Message.create(:user => @user)
      expected = "<a href=\"/messages/#{message.id}/edit\">Edit</a>"
      assert_equal expected, edit_link(message)
    end

    should 'create an edit link for an event' do
      message = Message.create(:user => @user, :is_event => true)
      expected = "<a href=\"/events/#{message.id}/edit\">Edit</a>"
      assert_equal expected, edit_link(message)
    end

    should 'do nothing when message does not belong to current user' do
      message = Message.create(:user => User.new)
      assert_nil edit_link(message)
    end
  end

  context 'destroy link' do
    setup do
      @user = User.create(:username => 'master shifu')
      stubs(:current_user).returns(@user)
    end

    should 'create a destroy link for a message' do
      message = Message.create(:user => @user)
      expected = "<a href=\"/messages/#{message.id}\" data-method=\"delete\" rel=\"nofollow\">Del</a>"
      assert_equal expected, destroy_link(message)
    end

    should 'do nothing when message does not belong to current user' do
      message = Message.create(:user => User.new)
      assert_nil destroy_link(message)
    end
  end

  context 'reply count' do
    setup do
      @message = Factory.create(:message)
    end
    should 'display correct number of replies' do
      @message.replies.create(:text => 'foo')
      @message.replies.create(:text => 'foo')
      assert_equal '2 replies', reply_count(@message)
    end

    should 'display in singular form when only one reply' do
      @message.replies.create(:text => 'foo')
      assert_equal '1 reply', reply_count(@message)
    end

    should 'display nothing when there are no replies' do
      assert_nil reply_count(@message)
    end
  end

  context 'today count' do
    should 'not show a count when there are no events today' do
      assert_equal 'Today', today_label
    end

    should 'show a count for all the events today' do
      Message.stubs(:today_count).returns(3)
      assert_equal 'Today (3)', today_label
    end
  end

  context 'forecast count' do
    should 'not show a count when there are no up comming events' do
      assert_equal 'Forecast', forecast_label
    end

    should 'show a count for all the up comming events' do
      Message.stubs(:forecast_count).returns(7)
      assert_equal 'Forecast (7)', forecast_label
    end
  end
end
