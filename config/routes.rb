Rails.application.routes.draw do
  get 'dashboard' => 'acao/dashboard/main#index'

  get 'radar' => 'radar#main'
  get 'meteo' => 'meteo#main'

  root :to => redirect('/dashboard')
end
