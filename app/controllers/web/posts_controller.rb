# frozen_string_literal: true

class Web::PostsController < Web::ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :load_post, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def show
    @comment = PostComment.new
    @current_user_like = @post.likes.find_by(user: current_user)
  end

  def new
    @post = Post.new
  end

  def create
    form = Web::PostForm.new(post_params)
    @post = current_user.posts.build(form.attributes)
    if @post.save
      redirect_to @post, notice: t('messages.post_created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    post = @post.becomes(Web::PostForm)
    if post.update(post_params)
      redirect_to @post, notice: t('messages.post_updated')
    else
      @post = post.becomes(Post)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy

    redirect_to root_path, notice: t('messages.post_destroyed')
  end

  private

  def post_params
    params.require(:post)
  end

  def load_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    redirect_to root_path, notice: t('messages.unauthorized_user') unless current_user.author_of?(@post)
  end
end
