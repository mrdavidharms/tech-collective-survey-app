Rails.application.routes.draw do
  devise_for :admins
  resources :admins
  resources :surveys

  resources :surveys do
    resources :questions
  end
  resources :question do
    resources :answers, only: [:new, :create, :show, :index]
  end

  root "surveys#index"
end
