Rails.application.routes.draw do
  root to: 'questions#index'
  devise_for :users

  resources :questions do
    get 'mark_best', on: :member
    resources :answers, only: [:new, :edit, :destroy, :create, :update]
  end

  resources :comments, except: [:index, :show]

  post 'new_vote', to: 'votes#new'

  get 'recent_questions', to: 'questions#recent'
  get 'popular_questions', to: 'questions#popular'
  get 'trending_questions', to: 'questions#trending'
  get 'user_profile', to: 'users#show'

end
