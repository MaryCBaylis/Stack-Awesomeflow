Rails.application.routes.draw do
  root to: 'pages#index'
  resources :pages
  devise_for :users

  resources :questions
  
end
