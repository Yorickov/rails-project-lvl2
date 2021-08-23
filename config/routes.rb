# frozen_string_literal: true

# == Route Map
#
#                   Prefix Verb   URI Pattern                       Controller#Action
#         new_user_session GET    /users/login(.:format)            devise/sessions#new
#             user_session POST   /users/login(.:format)            devise/sessions#create
#     destroy_user_session DELETE /users/logout(.:format)           devise/sessions#destroy
#        new_user_password GET    /users/password/new(.:format)     devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)    devise/passwords#edit
#            user_password PATCH  /users/password(.:format)         devise/passwords#update
#                          PUT    /users/password(.:format)         devise/passwords#update
#                          POST   /users/password(.:format)         devise/passwords#create
# cancel_user_registration GET    /users/cancel(.:format)           devise/registrations#cancel
#    new_user_registration GET    /users/sign_up(.:format)          devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)             devise/registrations#edit
#        user_registration PATCH  /users(.:format)                  devise/registrations#update
#                          PUT    /users(.:format)                  devise/registrations#update
#                          DELETE /users(.:format)                  devise/registrations#destroy
#                          POST   /users(.:format)                  devise/registrations#create
#    new_user_confirmation GET    /users/confirmation/new(.:format) devise/confirmations#new
#        user_confirmation GET    /users/confirmation(.:format)     devise/confirmations#show
#                          POST   /users/confirmation(.:format)     devise/confirmations#create
#                     root GET    /                                 landing#index

Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  root 'landing#index'

  resources :posts, except: %i[edit update destroy] do
    resources :post_comments, only: %i[index new create]
  end
end
