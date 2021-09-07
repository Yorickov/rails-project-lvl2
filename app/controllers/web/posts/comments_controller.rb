# frozen_string_literal: true

class Web::Posts::CommentsController < Web::Posts::ApplicationController
  before_action :authenticate_user!
  before_action :load_post
  before_action :load_comment, only: %i[edit update]
  before_action :authorize_user!, only: %i[edit update]

  def create
    @comment = @post.comments.new(post_comment_params.merge(user: current_user))
    if @comment.save
      redirect_to @post
    else
      flash.now[:notice] = t('messages.empty_comment')
      render 'web/posts/show', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @comment.update(post_comment_params)
      redirect_to @post
    else
      render 'web/posts/show', status: :unprocessable_entity
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end

  def load_post
    @post = Post.find(params[:post_id])
  end

  def load_comment
    @comment = PostComment.find(params[:id])
  end

  def authorize_user!
    redirect_to root_path, notice: t('messages.unauthorized_user') unless current_user.author_of?(@comment)
  end
end
