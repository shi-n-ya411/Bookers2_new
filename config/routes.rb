
Rails.application.routes.draw do
  root to: "homes#top"
  get 'home/about', to: 'homes#about', as: 'about'
  devise_for :users
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:show, :edit, :index, :update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end