require 'test_helper'

class HomeHelperTest < ActionView::TestCase

  should 'display the current date in a nice format' do
    fake_today = Date.new(2010, 5, 18)
    Date.stubs(:today).returns(fake_today)
    assert_equal 'Tuesday, May 18, 2010', today
  end

  should 'format date and time (AM)' do
    dt = DateTime.new(2010, 5, 18, 1, 11)
    assert_equal '05/18/2010 at 1:11 AM', format_datetime(dt)
  end

  should 'format date and time (PM)' do
    dt = DateTime.new(2010, 5, 18, 17, 55)
    assert_equal '05/18/2010 at 5:55 PM', format_datetime(dt)
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

  context 'event info' do
    setup do
      class << self
        include Haml::Helpers
      end
      init_haml_helpers
      @message = Message.new({:is_event => true, :start_at => DateTime.new(2010, 5, 5)})
    end

    should 'return nil when not an event' do
      message = Message.new
      assert_nil event_info(message)
    end

    should 'output event info markup with start at date only' do
      actual = capture_haml do
        event_info @message
      end

      expected =<<HTML
<p class='event-info'>
  05/05/2010 at 12:00 AM
</p>
HTML
      assert_equal expected, actual
    end

    should 'output event info markup with start at and end at date' do
      @message.end_at = Date.new(2010, 5, 6)
      actual = capture_haml do
        event_info @message
      end

      expected =<<HTML
<p class='event-info'>
  05/05/2010 at 12:00 AM
  to 05/06/2010 at 12:00 AM
</p>
HTML

      assert_equal expected, actual
    end
  end

end
