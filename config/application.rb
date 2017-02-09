require_relative 'boot'

require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AcaoDashboardFrontend
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.assets.paths << File.join(Rails.root, 'app', 'assets', 'js')
    config.assets.paths << File.join(Rails.root, 'app', 'assets', 'css')

    config.extgui.page_title = 'ACAO Dashboard'
    config.extgui.application = 'AcaoDashboard.Application'
    config.extgui.routes.merge!({ 'AcaoDashboard' => 'AcaoDashboard' })
    config.extgui.default_theme = :neptune
    config.extgui.main_css = 'acao_dashboard.css'
    config.extgui.favicon = 'acao_dashboard/favicon.png'
  end
end
