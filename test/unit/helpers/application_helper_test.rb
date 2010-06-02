require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  should 'format date and time (AM)' do
    dt = DateTime.new(2010, 5, 18, 1, 11)
    assert_equal '05/18/2010 at 1:11 AM', format_datetime(dt)
  end

  should 'format date and time (PM)' do
    dt = DateTime.new(2010, 5, 18, 17, 55)
    assert_equal '05/18/2010 at 5:55 PM', format_datetime(dt)
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
