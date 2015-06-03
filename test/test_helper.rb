ENV['RAILS_ENV'] ||= 'test'
$:.unshift File.dirname(__FILE__)
require 'rails_app/config/environment'
require 'rails/test_help'
require 'helpers/template_helper'
require 'database_cleaner'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
end
