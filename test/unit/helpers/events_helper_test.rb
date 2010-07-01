require 'test_helper'

class EventsHelperTest < ActionView::TestCase
  context 'time_opts' do
    should 'have "12:00 am" as the first item in list' do
      assert_equal '12:00 am', time_opts.first
    end

    should 'have 48 items' do
      assert_equal time_opts.length, 48
    end

    should 'have "11:30 pm" as the last item in list' do
      assert_equal '11:30 pm', time_opts.last
    end

    should 'incriment by a half hour' do
      assert_equal '12:00 am', time_opts[0]
      assert_equal '12:30 am', time_opts[1]
      assert_equal '1:00 am',  time_opts[2]
      assert_equal '1:30 am',  time_opts[3]
    end
  end
end
