ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  def assert_saved_model(model_name)
    assert assigns[model_name], "Should have a #{model_name}"
    assert assigns[model_name].persisted?, "#{model_name} should be persisted"
  end
end