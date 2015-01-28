require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Promeni
  class Application < Rails::Application
    config.time_zone = 'Sofia'
    config.i18n.available_locales = [:bg]
    config.i18n.default_locale = :bg

    config.to_prepare do
      DeviseController.respond_to :html, :json
    end

    config.action_mailer.default_options = { from: ENV['default_options_from'] }
    config.action_mailer.default_url_options = {
      host: ENV['default_url_options_host'],
      protocol: ENV['default_url_options_protocol']
    }
    config.action_mailer.delivery_method = ENV['delivery_method'].to_sym
  end
end
