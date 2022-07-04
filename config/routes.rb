Rails.application.routes.draw do
  resources :tickets, :except => [:new, :edit]
  resources :workers, :except => [:new, :edit]
  patch '/state/:id', to: 'tickets#state'
  patch '/change_worker/:id', to: 'tickets#change_worker'
end
