# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  scope module: :web do
    root 'home#index'

    resources :posts, except: :index do
      scope module: :posts do
        resources :comments, only: %i[create update]
        resources :likes, only: %i[create destroy]
      end
    end
  end
end
