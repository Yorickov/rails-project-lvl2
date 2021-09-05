# frozen_string_literal: true

SimpleCov.profiles.define 'basic' do
  add_filter '/config/'
  add_filter 'vendor'
end
