# frozen_string_literal: true

class Web::PostsController < Web::ApplicationController
  before_action :authenticate_user!, except: %i[show]

  def show
    @post = Post.find(params[:id])
    @comment = PostComment.new
    @current_user_like = @post.likes.find_by(user: current_user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: t('messages.post_created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post

    if @post.update(post_params)
      redirect_to @post, notice: t('messages.post_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post

    @post.destroy

    redirect_to root_path, notice: t('messages.post_destroyed')
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id)
  end
end
