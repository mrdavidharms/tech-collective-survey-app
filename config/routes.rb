Rails.application.routes.draw do
  devise_for :admins

    resources :admins
    resources :surveys

  root "surveys#index"
end
