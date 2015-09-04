ENV['RAILS_ENV'] ||= 'test'
$:.unshift File.dirname(__FILE__)

require 'rails_app/config/environment'
require 'rails/test_help'
require 'database_cleaner'
require 'minitest/rails/capybara'

# Capybara
Capybara.javascript_driver = :webkit

# DatabaseCleaner
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean_with(:truncation)

class ActiveSupport::TestCase
  def setup
    DatabaseCleaner.clean
  end
end
