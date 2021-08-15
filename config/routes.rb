# frozen_string_literal: true

# == Route Map
#
# Prefix Verb URI Pattern Controller#Action
#   root GET  /           landing#index

Rails.application.routes.draw do
  root 'landing#index'
end
