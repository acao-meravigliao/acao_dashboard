Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true

  config.assets.debug = false
  config.assets.digest = true

  config.assets.js_compressor = :uglifier
  config.assets.css_compressor = :sass

  # config.assets.raise_runtime_errors = true

  config.extgui.hel_host = 'http://[::1]:3330'

  config.assets.precompile += [
    /\w+\.(?!js|css)$/,
    'acao_dashboard.css',
    'acao_dashboard-stage1.js',
    'acao_dashboard-stage2.js',
    'ext/ext.js',
    'markerwithlabel.js',
    'ext/ext-theme-neptune.js',
    'ext/resources/ext-theme-classic/ext-theme-classic-all.css',
    'ext/resources/ext-theme-gray/ext-theme-gray-all.css',
    'ext/resources/ext-theme-access/ext-theme-access-all.css',
    'ext/resources/ext-theme-neptune/ext-theme-neptune-all.css',
    'ext/resources/ext-theme-redtune/ext-theme-redtune-all.css',
    'radar.js',
    'meteo.js',
    'metar.js',
  ]
end
