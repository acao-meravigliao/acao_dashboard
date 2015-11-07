Rails.application.routes.draw do
  get 'dashboard' => 'acao/dashboard/main#index'

  get 'radar' => 'radar#main'
  get 'meteo' => 'meteo#main'

#  get 'services' => 'extgui/main#index'

  root :to => redirect('/tracking/radar')
end
