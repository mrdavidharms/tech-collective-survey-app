Rails.application.routes.draw do
  devise_for :admins
  resources :admins
  resources :surveys

  resources :surveys do
    resources :questions
  end
  resources :questions do
    resources :answers
  end


  root "surveys#index"
end
