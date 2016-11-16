Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = false
  config.assets.raise_production_errors = false
  config.assets.check_precompiled_asset = false

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true


  # Avoid having precompiled assets being served
  config.assets.prefix = '/assets-dev'

  config.extgui.compile_trees << 'AcaoDashboard'

  config.extgui.ext_core_js = 'ext/ext-dev.js'
  config.extgui.hel_host = 'http://[::1]:3330'
  config.extgui.ws_uri = lambda { "ws://#{request.host}:3330/ws" }

  require_relative '../../lib/proxy'
  config.middleware.use Rack::Proxy do |req|
    if req.path =~ %r{^/ygg/(.*)}
      URI.parse("#{Rails.application.config.extgui.hel_host}/ygg/#{$1}?#{req.query_string}")
    end
  end
end
