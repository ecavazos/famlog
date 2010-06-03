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
      expected = "<a href=\"/messages/#{message.id}\" data-method=\"delete\" rel=\"nofollow\">Delete</a>"
      assert_equal expected, destroy_link(message)
    end

    should 'do nothing when message does not belong to current user' do
      message = Message.create(:user => User.new)
      assert_nil destroy_link(message)
    end
  end

  context 'reply count' do
    should 'display correct number of replies' do
      message = Message.new
      message.replies.build
      message.replies.build
      assert_equal '2 replies', reply_count(message)
    end

    should 'display in singular form when only one reply' do
      message = Message.new
      message.replies.build
      assert_equal '1 reply', reply_count(message)
    end

    should 'display nothing when there are no replies' do
      message = Message.new
      assert_nil reply_count(message)
    end
  end
end
