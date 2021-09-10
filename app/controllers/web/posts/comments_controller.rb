# frozen_string_literal: true

class Web::Posts::CommentsController < Web::Posts::ApplicationController
  def create
    @comment = resource_post.comments.new(post_comment_params.merge(user: current_user))
    if @comment.save
      redirect_to resource_post
    else
      flash.now[:notice] = t('messages.empty_comment')
      @post = resource_post
      render 'web/posts/show', status: :unprocessable_entity
    end
  end

  def update
    @comment = resource_post.comments.find(params[:id])
    unless current_user.author_of?(@comment)
      flash[:notice] = t('messages.unauthorized_user')
      redirect_to root_path and return
    end

    if @comment.update(post_comment_params)
      redirect_to resource_post
    else
      @post = resource_post
      render 'web/posts/show', status: :unprocessable_entity
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
