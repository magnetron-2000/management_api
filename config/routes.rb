Rails.application.routes.draw do
  post 'sign_up', to: 'users/registrations#create'
  patch 'users/add_admin/:id', to: 'users/admins#add_to_admins'
  patch 'users/remove_admin/:id', to: 'users/admins#remove_from_admins'


  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  resources :tickets, :except => [:new, :edit] do
    member do
      patch :change_worker
      patch :state
    end
  end

  resources :workers, :except => [:new, :edit] do
    member do
      patch :activate
      patch :deactivate
    end
  end
end
