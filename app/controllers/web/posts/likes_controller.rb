# frozen_string_literal: true

class Web::Posts::LikesController < Web::Posts::ApplicationController
  def create
    @like = post.likes.build(user: current_user)
    if @like.save
      redirect_to post
    else
      redirect_to post, alert: t('messages.double_like')
    end
  end

  def destroy
    @like = post.likes.find(params[:id])
    @like.destroy

    redirect_to post
  end
end
