Rails.application.routes.draw do
  root :to => 'ygg/acao/dashboard/main#index'

  scope module: 'ygg/acao' do
    get 'dashboard' => 'dashboard/main#index'

    get 'radar' => 'radar#main'
    get 'radar/embed' => 'radar#embed'
    get 'meteo' => 'meteo#main'
    get 'metar' => 'meteo#metar'
  end
end
