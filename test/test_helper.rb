ENV['RAILS_ENV'] ||= 'test'
$:.unshift File.dirname(__FILE__)
require 'rails_app/config/environment'
require 'rails/test_help'
require 'database_cleaner'
require 'minitest/rails/capybara'
require 'mongosteen'

Capybara.javascript_driver = :webkit
DatabaseCleaner[:mongoid].strategy = :truncation

class ActiveSupport::TestCase
  def setup
    DatabaseCleaner.clean
  end
end
