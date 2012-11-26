ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

FactoryGirl.find_definitions
require 'turn/autorun'

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
end

class Test::Unit::TestCase
  def teardown
    DatabaseCleaner.clean
  end
end
