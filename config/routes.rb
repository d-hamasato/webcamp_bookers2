Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"
  get "home/about" => "homes#about", as: "about"

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
  end
end