# frozen_string_literal: true

class Web::Posts::LikesController < Web::Posts::ApplicationController
  def create
    @like = resource_post.likes.build(user: current_user)
    if @like.save
      redirect_to resource_post
    else
      redirect_to resource_post, alert: t('messages.double_like')
    end
  end

  def destroy
    @like = resource_post.likes.find(params[:id])
    @like.destroy

    redirect_to resource_post
  end
end
