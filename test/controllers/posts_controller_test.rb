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
    @another_post = posts(:two)
  end

  teardown do
    Rails.cache.clear
  end

  test '#index' do
    get posts_url

    assert_response :success
  end

  test '#show' do
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

    assert_redirected_to new_user_session_url
  end

  test '#create as User success' do
    sign_in users(:one)

    assert_difference('Post.count') do
      post posts_url, params: { post: @post_params }
    end
    assert_redirected_to Post.last
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
    assert_redirected_to new_user_session_url
  end

  test '#edit as User' do
    sign_in users(:one)

    get edit_post_url(@post)

    assert_response :success
  end

  test '#edit as Guest' do
    get edit_post_url(@post)

    assert_redirected_to new_user_session_url
  end

  test '#update as User success' do
    sign_in users(:one)

    patch post_url(@post), params: { post: { **@post_params, body: @another_post.body } }
    assert_redirected_to @post

    @post.reload
    assert_equal @another_post.body, @post.body
  end

  test '#update as User failed' do
    sign_in users(:one)
    @post_params[:body] = nil

    patch post_url(@post), params: { post: @post_params }

    assert_response :unprocessable_entity
  end

  test '#update as Guest' do
    patch post_url(@post), params: { post: @post_params }

    assert_redirected_to new_user_session_url
  end

  test '#destroy as User success' do
    sign_in users(:one)

    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end
    assert_redirected_to posts_url
  end

  test '#destroy as Guest' do
    assert_no_difference('Post.count') do
      delete post_url(@post)
    end
    assert_redirected_to new_user_session_url
  end
end
