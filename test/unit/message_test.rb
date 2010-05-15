require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  test 'should save' do
    Message.create
    assert_equal 1, Message.all.count
  end

  context 'Message' do
    setup do
      @message = Message.new({
        :is_event => false
      })
    end

    should 'have a type name of "Message"' do
      assert_equal 'Message', @message.type_name
    end

    should 'not have an end date' do
      assert !@message.end_date?, 'expected end_date? to return false'
    end

    should 'not have a start date display' do
      assert_nil @message.start_date_display
    end

    should 'not have a start time display' do
      assert_nil @message.start_time_display
    end

    should 'not have an end date display' do
      assert_nil @message.end_date_display
    end

    should 'not have an end time display' do
      assert_nil @message.end_time_display
    end

    should 'have a low importance by default' do
      assert_equal Importance::LOW, @message.importance
    end
  end

  context 'Event' do
    setup do
      @message = Message.new({
        :is_event => true
      })
    end

    should 'have a type name of "Event"' do
      assert_equal 'Event', @message.type_name
    end

    should 'have an end date' do
      @message.start_at = Date.today - 1
      @message.end_at = Date.today
      assert @message.end_date?, 'end date was not present'
    end

    should 'not have an end date when start at and end at are same' do
      @message.start_at = Date.today
      @message.end_at = Date.today
      assert !@message.end_date?, 'expected end_date? to return false'
    end

    should 'display start at date as mm/dd/yyyy' do
      @message.start_at = DateTime.new(2010, 2, 22)
      assert_equal '02/22/2010', @message.start_date_display
    end

    should 'display start at time as 2:22 pm' do
      @message.start_at = DateTime.new(2010, 2, 22, 14, 22)
      assert_equal '2:22 pm', @message.start_time_display
    end

    should 'display end at date as mm/dd/yyyy' do
      @message.end_at = DateTime.new(2010, 2, 22)
      assert_equal '02/22/2010', @message.end_date_display
    end

    should 'display end at time as 2:22 pm' do
      @message.end_at = DateTime.new(2010, 2, 22, 14, 22)
      assert_equal '2:22 pm', @message.end_time_display
    end
  end
end
