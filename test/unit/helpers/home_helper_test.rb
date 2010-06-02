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

  context 'to edit' do
    setup do
      @user = User.create(:username => 'iron man')
      stubs(:current_user).returns(@user)
    end

    should 'create an edit link for a message' do
      message = Message.create(:user => @user)
      expected = "<a href=\"/messages/#{message.id}/edit\">Edit</a>"
      assert_equal expected, to_edit(message)
    end

    should 'create an edit link for an event' do
      message = Message.create(:user => @user, :is_event => true)
      expected = "<a href=\"/events/#{message.id}/edit\">Edit</a>"
      assert_equal expected, to_edit(message)
    end

    should 'do nothing when message does not belong to current user' do
      message = Message.create(:user => User.new)
      assert_nil to_edit(message)
    end

  end
end
