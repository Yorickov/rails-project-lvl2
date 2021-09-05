# frozen_string_literal: true

require 'test_helper'

class Web::Posts::LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    register_user_and_another_user

    @post1 = posts(:one)
    @post2 = posts(:two)
    @like1 = post_likes(:one)
    @like2 = post_likes(:two)
  end

  test '#create no more than one like as User' do
    sign_in @user

    assert_difference('PostLike.count') do
      post post_likes_url(@post2)
    end
    assert_redirected_to @post2

    assert_no_difference('PostLike.count') do
      post post_likes_url(@post2)
    end
    assert_redirected_to @post2
  end

  test '#create as Guest' do
    post post_likes_url(@post2)

    assert_redirected_to new_user_session_path
  end

  test '#destroy as User' do
    sign_in @user

    assert_difference('PostLike.count', -1) do
      delete post_like_url(@post1, @like1)
    end
    assert_redirected_to @post1
  end

  test '#destroy as Guest' do
    delete post_like_url(@post1, @like1)

    assert_redirected_to new_user_session_path
  end
end
