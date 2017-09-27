Rails.application.routes.draw do
  root :to => redirect('index.html')

  get 'dashboard' => 'dashboard/main#index'

  scope module: 'ygg/acao' do
    get 'radar' => 'radar#main'
    get 'radar/embed' => 'radar#embed'
    get 'meteo' => 'meteo#main'
    get 'metar' => 'meteo#metar'
  end
end
