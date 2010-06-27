require 'test_helper'

class EventsHelperTest < ActionView::TestCase
  context 'times' do
    should 'have "12:00 am" as the first item in list' do
      assert_equal '12:00 am', times.first
    end

    should 'have 48 items' do
      assert_equal times.length, 48
    end

    should 'have "11:30 pm" as the last item in list' do
      assert_equal '11:30 pm', times.last
    end

    should 'incriment by a half hour' do
      assert_equal '12:00 am', times[0]
      assert_equal '12:30 am', times[1]
      assert_equal '1:00 am',  times[2]
      assert_equal '1:30 am',  times[3]
    end
  end
end
