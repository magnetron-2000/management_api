Rails.application.routes.draw do
  resources :tickets, :except => [:new, :edit]
  resources :workers, :except => [:new, :edit]
  patch '/state/:id', to: 'tickets#state'
  patch '/change_worker/:id', to: 'tickets#change_worker'
  patch '/activate/:id', to: 'workers#activate_worker'
  patch '/deactivate/:id', to: 'workers#deactivate_worker'
end
