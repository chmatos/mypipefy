# frozen_string_literal: true
require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ReviewsCore
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.assets.paths << Rails.root.join("app", "assets", "flash")
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.exceptions_app = self.routes

    config.i18n.default_locale = :"pt-BR"

    #config.after_initialize do |app|
  	#	app.routes.append{ match '*a', :to => 'application#not_found' ,via: :all } unless config.consider_all_requests_local

    config.assets.precompile += %w( .svg .eot .woff .ttf .sass .scss)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
