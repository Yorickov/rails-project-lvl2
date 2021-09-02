# frozen_string_literal: true

# == Route Map
#
#                        Prefix Verb   URI Pattern                                             Controller#Action
#              new_user_session GET    /users/login(.:format)                                  devise/sessions#new
#                  user_session POST   /users/login(.:format)                                  devise/sessions#create
#          destroy_user_session DELETE /users/logout(.:format)                                 devise/sessions#destroy
#             new_user_password GET    /users/password/new(.:format)                           devise/passwords#new
#            edit_user_password GET    /users/password/edit(.:format)                          devise/passwords#edit
#                 user_password PATCH  /users/password(.:format)                               devise/passwords#update
#                               PUT    /users/password(.:format)                               devise/passwords#update
#                               POST   /users/password(.:format)                               devise/passwords#create
#      cancel_user_registration GET    /users/cancel(.:format)                                 devise/registrations#cancel
#         new_user_registration GET    /users/sign_up(.:format)                                devise/registrations#new
#        edit_user_registration GET    /users/edit(.:format)                                   devise/registrations#edit
#             user_registration PATCH  /users(.:format)                                        devise/registrations#update
#                               PUT    /users(.:format)                                        devise/registrations#update
#                               DELETE /users(.:format)                                        devise/registrations#destroy
#                               POST   /users(.:format)                                        devise/registrations#create
#         new_user_confirmation GET    /users/confirmation/new(.:format)                       devise/confirmations#new
#             user_confirmation GET    /users/confirmation(.:format)                           devise/confirmations#show
#                               POST   /users/confirmation(.:format)                           devise/confirmations#create
#                          root GET    /                                                       web/landing#index
#                 post_comments POST   /posts/:post_id/comments(.:format)                      web/posts/comments#create
#                         posts GET    /posts(.:format)                                        web/posts#index
#                               POST   /posts(.:format)                                        web/posts#create
#                      new_post GET    /posts/new(.:format)                                    web/posts#new
#                     edit_post GET    /posts/:id/edit(.:format)                               web/posts#edit
#                          post GET    /posts/:id(.:format)                                    web/posts#show
#                               PATCH  /posts/:id(.:format)                                    web/posts#update
#                               PUT    /posts/:id(.:format)                                    web/posts#update
#                               DELETE /posts/:id(.:format)                                    web/posts#destroy
# rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format) action_mailbox/ingresses/postmark/inbound_emails#create

Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  scope module: :web do
    root 'landing#index'

    resources :posts do
      scope module: :posts do
        resources :comments, only: %i[create edit update destroy]
      end
    end
  end
end
