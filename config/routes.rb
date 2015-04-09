Rails.application.routes.draw do
  root to: 'questions#index'
  resources :pages
  devise_for :users

  resources :questions
  
end
