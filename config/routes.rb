Rails.application.routes.draw do
  root to: 'questions#index'
  resources :pages
  devise_for :users

  resources :questions do
    get 'mark_best', on: :member
    resources :answers, only: [:new, :edit, :destroy, :create, :update]
  end

  resources :votes, only: [:create]
  
end
