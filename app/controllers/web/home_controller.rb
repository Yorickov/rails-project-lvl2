# frozen_string_literal: true

class Web::HomeController < ApplicationController
  def index
    @posts = Post.includes(:user).order(created_at: :desc).page params[:page]
  end
end
