# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_post, only: %i[show]

  def index
    @posts = Post.includes(:user).all
  end

  def show
    @comment = Post::Comment.new(post: @post)
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: t('messages.post_created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id)
  end

  def load_post
    @post = Post.find(params[:id])
  end
end
