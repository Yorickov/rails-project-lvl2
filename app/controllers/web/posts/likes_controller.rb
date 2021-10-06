# frozen_string_literal: true

class Web::Posts::LikesController < Web::Posts::ApplicationController
  def create
    @like = post.likes.build(user: current_user)
    flash.now[:notice] = t('messages.double_like') unless @like.save

    redirect_to post
  end

  def destroy
    @like = post.likes.find(params[:id])
    @like.destroy

    redirect_to post
  end
end
