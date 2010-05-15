ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require "shoulda"
require 'factory_girl'
Factory.definition_file_paths = [ File.join(Rails.root, 'test', 'factories') ]
Factory.find_definitions
require "mocha"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  # Add more helper methods to be used by all tests here...

  # MongoDB has no transactions. Drop all collections after each test case.
  def teardown
    Mongoid.database.collections.each(&:drop)
  end

  # Make sure that each test case has a teardown
  # method to clear the db after each test.
  def inherited(base)
    base.define_method teardown do
      super
    end
  end

end
