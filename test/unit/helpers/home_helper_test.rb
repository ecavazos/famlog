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
end
