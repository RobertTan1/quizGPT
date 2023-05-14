Rails.application.routes.draw do
  get 'results/index'
  resources :users, only: [:new, :create] do
    resources :questions, only: [:index, :create]
    resources :results, only: [:index]

  end

  root to: 'users#new'
end
