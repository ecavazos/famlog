require 'test/test_helper'
require 'lib/famlog/datetime_parser'

class DateTimeParserTester < Test::Unit::TestCase
  context Famlog::DateTimeParser do

    should 'parse date without time value' do
      actual = Famlog::DateTimeParser.parse('5/11/2010')
      assert_equal(DateTime.new(2010, 5, 11), actual)
    end

    should 'parse date with dashes' do
      actual = Famlog::DateTimeParser.parse('5-11-2010')
      assert_equal(DateTime.new(2010, 5, 11), actual)
    end

    should 'parse date when month has leading zero' do
      actual = Famlog::DateTimeParser.parse('05-11-2010')
      assert_equal(DateTime.new(2010, 5, 11), actual)
    end

    should 'parse date when day has leading zero' do
      actual = Famlog::DateTimeParser.parse('05-07-2010')
      assert_equal(DateTime.new(2010, 5, 7), actual)
    end

    should 'return nil when date value is nil' do
      actual = Famlog::DateTimeParser.parse
      assert_equal(nil, actual)
    end

    should 'return nil when date value is empty' do
      actual = Famlog::DateTimeParser.parse('')
      assert_equal(nil, actual)
    end

    should 'parse date and time' do
      actual = Famlog::DateTimeParser.parse('05-11-2010', '1:30 pm')
      assert_equal(DateTime.new(2010, 5, 11, 13, 30), actual)
    end

    should 'parse date and time when hour has leading zero' do
      actual = Famlog::DateTimeParser.parse('05-11-2010', '01:30 am')
      assert_equal(DateTime.new(2010, 5, 11, 1, 30), actual)
    end

    should 'parse date and time when minute and meridian value are not seperated by a space' do
      actual = Famlog::DateTimeParser.parse('05-11-2010', '1:30pm')
      assert_equal(DateTime.new(2010, 5, 11, 13, 30), actual)
    end
  end
end
