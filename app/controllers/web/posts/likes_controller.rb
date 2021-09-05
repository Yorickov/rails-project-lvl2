# frozen_string_literal: true

class Web::Posts::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_post

  def create
    @like = @post.likes.build(user: current_user)
    if @like.save
      redirect_to @post
    else
      redirect_to @post, alert: t('messages.double_like')
    end
  end

  def destroy
    @like = PostLike.find(params[:id])
    @like.destroy

    redirect_to @post
  end

  private

  def load_post
    @post = Post.find(params[:post_id])
  end
end
