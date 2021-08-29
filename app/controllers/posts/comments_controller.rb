# frozen_string_literal: true

class Posts::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_post, only: :create

  def create
    @comment = @post.comments.new(post_comment_params.merge(user: current_user))
    if @comment.save
      redirect_to @post
    else
      flash.now[:notice] = t('messages.empty_comment')
      render 'posts/show', status: :unprocessable_entity
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end

  def load_post
    @post = Post.find(params[:post_id])
  end
end
