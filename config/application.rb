require_relative 'boot'

require 'rails'
require 'action_controller/railtie'
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

    config.app_version = /releases\/([0-9]+)/.match(File.expand_path(__dir__)) ? "rel-#{$1}" : (
                           `git describe --tags --dirty --long` || `git rev-parse HEAD`).chop

    config.extgui.page_title = 'ACAO Dashboard'
    config.extgui.application = 'AcaoDashboard.Application'
    config.extgui.routes.merge!({ 'AcaoDashboard' => 'AcaoDashboard' })
    config.extgui.default_theme = :neptune
    config.extgui.main_css = 'acao_dashboard.css'
    config.extgui.favicon = 'acao_dashboard/favicon.png'
    config.extgui.extra_config = {
      airbrake: {
        host: 'https://errbit.sevio.it',
        project_id: 1,
        project_key: 'e40084d37d570083fa8d716f345b6308',
      },
    }
  end
end
