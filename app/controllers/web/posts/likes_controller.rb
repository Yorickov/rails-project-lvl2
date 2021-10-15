# frozen_string_literal: true

class Web::Posts::LikesController < Web::Posts::ApplicationController
  def create
    post.likes.create(user: current_user)

    redirect_to post
  end

  def destroy
    @like = post.likes.find(params[:id])
    @like.destroy

    redirect_to post
  end
end
