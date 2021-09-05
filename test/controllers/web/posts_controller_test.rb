# frozen_string_literal: true

require 'test_helper'

class Web::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    register_user_and_another_user

    @post = posts(:one)
    @post_params = {
      title: @post.title,
      body: @post.body,
      post_category_id: @post.post_category_id
    }
    @another_post = posts(:two)
  end

  # TODO: needed?
  teardown do
    Rails.cache.clear
  end

  test '#show' do
    get post_url(@post)

    assert_response :success
  end

  test '#new as User' do
    sign_in @user

    get new_post_url

    assert_response :success
  end

  test '#new as Guest' do
    get new_post_url

    assert_redirected_to new_user_session_path
  end

  test '#create as User success' do
    sign_in @user

    assert_difference('Post.count') do
      post posts_url, params: { post: @post_params }
    end
    assert_redirected_to Post.last
  end

  test '#create as User failed' do
    sign_in @user

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

  test '#edit as authorized User' do
    sign_in @user

    get edit_post_url(@post)

    assert_response :success
  end

  test '#edit as unauthorized User' do
    sign_in @another_user

    get edit_post_url(@post)

    assert_redirected_to root_path
  end

  test '#edit as Guest' do
    get edit_post_url(@post)

    assert_redirected_to new_user_session_path
  end

  test '#update as authorized User success' do
    sign_in @user

    patch post_url(@post), params: { post: { **@post_params, body: @another_post.body } }
    assert_redirected_to @post

    @post.reload
    assert { @another_post.body == @post.body }
  end

  test '#update as User failed' do
    sign_in @user
    @post_params[:body] = nil

    patch post_url(@post), params: { post: @post_params }

    assert_response :unprocessable_entity
  end

  test '#update as unauthorized User' do
    sign_in @another_user

    patch post_url(@post), params: { post: { **@post_params, body: @another_post.body } }
    assert_redirected_to root_path

    @post.reload
    assert { @another_post.body != @post.body }
  end

  test '#update as Guest' do
    patch post_url(@post), params: { post: @post_params }

    assert_redirected_to new_user_session_path
  end

  test '#destroy as authorized User' do
    sign_in @user

    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end
    assert_redirected_to root_path
  end

  test '#destroy as unauthorized User' do
    sign_in @another_user

    assert_no_difference('Post.count') do
      delete post_url(@post)
    end
    assert_redirected_to root_path
  end

  test '#destroy as Guest' do
    assert_no_difference('Post.count') do
      delete post_url(@post)
    end
    assert_redirected_to new_user_session_path
  end
end
