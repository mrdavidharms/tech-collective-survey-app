Rails.application.routes.draw do
  devise_for :admins
  resources :admins
  resources :surveys

  resources :surveys do
    resources :questions
  end
  root "surveys#index"
end
