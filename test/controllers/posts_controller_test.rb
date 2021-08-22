# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    @post_params = {
      title: @post.title,
      body: @post.body,
      post_category_id: @post.post_category_id
    }
  end

  teardown do
    Rails.cache.clear
  end

  test '#index' do
    get posts_url

    assert_response :success
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end

  test '#new as User' do
    sign_in users(:one)

    get new_post_url

    assert_response :success
  end

  test '#new as Guest' do
    get new_post_url

    assert_redirected_to new_user_session_path
  end

  test '#create as User success' do
    sign_in users(:one)

    assert_difference('Post.count') do
      post posts_url, params: { post: @post_params }
    end

    assert_redirected_to post_url(Post.last)
  end

  test '#create as User failed' do
    sign_in users(:one)
    @post_params[:title] = nil

    assert_no_difference('Post.count') do
      post posts_url, params: { post: @post_params }
    end

    assert_response :unprocessable_entity
  end

  test '#create as Guest' do
    assert_no_difference('Post.count') do
      post posts_url, params: { post: @post_params }
    end

    assert_redirected_to new_user_session_path
  end
end
