Rails.application.routes.draw do
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
