Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, only: %i[new create index show edit update destroy] do
    resources :buys, only: %i[index create]
  end
end
