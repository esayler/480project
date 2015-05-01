require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Project
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.assets.initialize_on_precompile = true 

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # manually set up settings for generators
    # if we need helper specs, add those manually
    config.generators do |g|
      g.test_framework :rspec,
        # generate a fixture for each model (using factory_girl factory)
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: true,
        controller_specs: true,
        request_specs: false
      # generate factories instead of fixtures, save them to spec/factories
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
  end
end
