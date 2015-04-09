Rails.application.routes.draw do
  devise_for :users

  resources :questions do
    resources :answers, only: [:new, :edit, :destroy, :create, :update]
  end
  
end
