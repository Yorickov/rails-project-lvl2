# frozen_string_literal: true

class Web::Posts::CommentsController < Web::Posts::ApplicationController
  def create
    @comment = post.comments.build(post_comment_params.merge(user: current_user))
    if @comment.save
      redirect_to post
    else
      flash.now[:notice] = t('messages.comment_can_not_be_empty')
      render 'web/posts/show', status: :unprocessable_entity
    end
  end

  def update
    @comment = post.comments.find(params[:id])

    authorize @comment

    if @comment.update(post_comment_params)
      redirect_to post
    else
      render 'web/posts/show', status: :unprocessable_entity
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
