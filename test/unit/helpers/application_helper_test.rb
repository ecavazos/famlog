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

  context 'rails_msg' do
    setup do
      class << self
        include Haml::Helpers
        def alert; "You've been alerted!" end
        def notice; "You've been noticed!" end
      end
      init_haml_helpers
    end

    should 'raise argument error when parameter cannot be handled' do
      e = assert_raise ArgumentError do
        rails_msg(:bogus)
      end
      assert_equal 'Can only handle alert and notice messages.', e.message
    end

    should 'return alert wrapped in a div tag' do
      actual = rails_msg(:alert)

      expected =<<HTML
<div id='alert'>
  You've been alerted!
</div>
HTML

      assert_equal expected, actual
    end

    should 'return notice wrapped in a div tag' do
      actual = rails_msg(:notice)

      expected =<<HTML
<div id='notice'>
  You've been noticed!
</div>
HTML

      assert_equal expected, actual
    end

    should 'return nothing when there are no alerts' do
      class << self
        def alert; nil end
      end
      assert_equal '', rails_msg(:alert)
    end

    should 'return nothing when there are no notices' do
      class << self
        def notice; nil end
      end
      assert_equal '', rails_msg(:notice)
    end
  end

end
