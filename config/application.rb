require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

Settings = YAML.load(File.read(File.expand_path('config/settings.yml'))).symbolize_keys

module Promeni
  class Application < Rails::Application
    config.time_zone = 'Sofia'
    config.i18n.available_locales = [:bg]
    config.i18n.default_locale = :bg
  end
end
