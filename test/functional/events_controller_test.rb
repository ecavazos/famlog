require 'test_helper'
require 'functional_helpers'

class EventsControllerTest < ActionController::TestCase
  include FunctionalHelpers

  setup do
    authenticate_user_mock
  end

  context 'create event without start/end at time values' do
    setup do
      @params = {
        's_date'  => '5/16/2010',
        'e_date'  => '5/17/2010',
        'message' => {
          'title' => 'foo'
        }
      }

      post :create, @params
    end

    should 'be an event' do
      assert assigns(:message).is_event?
    end

    should 'have correct start at date' do
      assert_equal DateTime.new(2010, 5, 16), assigns(:message).start_at
    end

    should 'have correct end at date' do
      assert_equal DateTime.new(2010, 5, 17), assigns(:message).end_at
    end
  end

  context 'create event with start/end at time values' do
    setup do
      @params = {
        's_date'  => '5/16/2010',
        's_time'  => '3:33 pm',
        'e_date'  => '5/17/2010',
        'e_time'  => '4:44 pm',
        'message' => {
          'title' => 'foo'
        }
      }

      post :create, @params
    end

    should 'be an event' do
      assert assigns(:message).is_event?
    end

    should 'have correct start at date' do
      actual = DateTime.new(2010, 5, 16, 15, 33)
      assert_equal actual, assigns(:message).start_at
    end

    should 'have correct end at date' do
      actual = DateTime.new(2010, 5, 17, 16, 44)
      assert_equal actual, assigns(:message).end_at
    end
  end

end
