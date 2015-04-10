Rails.application.routes.draw do
  root to: 'questions#index'
  devise_for :users

  resources :questions do
    get 'mark_best', on: :member
    resources :answers, only: [:new, :edit, :destroy, :create, :update]
  end

  resources :comments, except: [:index, :show]

  get 'new_vote', to: 'votes#new'

  get 'recent_questions', to: 'questions#recent'

end
