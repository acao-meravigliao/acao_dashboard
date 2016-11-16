Rails.application.routes.draw do
  get 'dashboard' => 'acao/dashboard/main#index'

  root :to => 'acao/dashboard/main#index'
end
