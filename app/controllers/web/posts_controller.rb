# frozen_string_literal: true

class Web::PostsController < Web::ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :load_post, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def show
    @comment = @post.comments.new
    @current_user_like = @post.likes.find_by(user: current_user)
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

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t('messages.post_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path, notice: t('messages.post_destroyed')
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id)
  end

  def load_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    redirect_to root_path, notice: t('messages.unauthorized_user') unless current_user.author_of?(@post)
  end
end
