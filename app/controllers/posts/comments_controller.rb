# frozen_string_literal: true

class Posts::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(post_comment_params)
    if @comment.save
      redirect_to @post
    else
      render 'posts/show'
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:content).merge(user: current_user)
  end
end
