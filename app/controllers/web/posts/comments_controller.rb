# frozen_string_literal: true

class Web::Posts::CommentsController < Web::Posts::ApplicationController
  def create
    form = Web::PostCommentForm.new(post_comment_params)
    @comment = post.comments.build(form.attributes)
    @comment.user = current_user
    if @comment.save
      redirect_to post
    else
      flash.now[:notice] = t('messages.empty_comment')
      render 'web/posts/show', status: :unprocessable_entity
    end
  end

  def update
    @comment = post.comments.find(params[:id])
    authorize @comment

    comment = @comment.becomes(Web::PostCommentForm)
    if comment.update(post_comment_params)
      redirect_to post
    else
      render 'web/posts/show', status: :unprocessable_entity
    end
  end

  private

  def post_comment_params
    params.require(:post_comment)
  end
end
