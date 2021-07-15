# frozen_string_literal: true

unless Rails.env.test?
  $moderate_parameters_logger = Logger.new('log/moderate_parameters.log')

  ActiveSupport::Notifications.subscribe('moderate_parameters') do |name, start, finish, id, payload|
    $moderate_parameters_logger.info "#{payload[:controller]}##{payload[:action]} #{payload[:message]}"
  end
end
