# frozen_string_literal: true

require "bundler/setup"
require "pry"
require "action_controller"
require "active_support"
require "moderate_parameters"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def notification_payload_for(notification)
  payload = nil
  subscription = ActiveSupport::Notifications.subscribe notification do |name, start, finish, id, _payload|
    payload = _payload
  end

  yield

  ActiveSupport::Notifications.unsubscribe(subscription)

  return payload
end
