Rails.application.routes.draw do
  get 'dashboard' => 'acao/dashboard/main#index'

  get 'radar' => 'radar#main'
  get 'meteo' => 'meteo#main'
  get 'meteo/metar' => 'meteo#metar'

  root :to => redirect('/dashboard')
end
