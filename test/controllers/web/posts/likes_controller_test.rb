# frozen_string_literal: true

require 'test_helper'

class Web::Posts::LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post1 = posts(:one)
    @post2 = posts(:two)
    @like1 = post_likes(:one)
  end

  test '#create like' do
    sign_in @user

    post post_likes_url(@post2)

    like = PostLike.find_by(user: @user, post: @post2)
    assert { like }
  end

  test '#destroy as User' do
    sign_in @user

    delete post_like_url(@post1, @like1)

    like = PostLike.find_by(user: @user, post: @post1)
    assert { !like }
  end
end
