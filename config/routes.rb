Rails.application.routes.draw do
  resources :tickets, :except => [:new, :edit]
  resources :workers, :except => [:new, :edit]
end
