require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EmotionalBalloon
  class Application < Rails::Application

    config.active_record.raise_in_transactional_callbacks = true

    config.paths.add "app/api", glob: "**/*.rb"
    config.autoload_paths += %W(#{config.root}/app/api)

    config.middleware.use(Rack::Config) do |env|
      env['api.tilt.root'] = Rails.root.join 'app', 'views', 'api'
    end

    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
  end

end