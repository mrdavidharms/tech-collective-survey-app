Rails.application.routes.draw do
  devise_for :admins
  resources :admins
  resources :surveys, only: [:new]

  root "surveys#index"
end
