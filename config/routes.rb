Rails.application.routes.draw do
  root to: 'questions#index'
  resources :pages
  devise_for :users

  resources :questions do
    resources :answers, only: [:new, :edit, :destroy, :create, :update]
  end
  
end
