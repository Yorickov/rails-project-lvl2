# frozen_string_literal: true

require 'test_helper'

class Web::Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    register_user_and_another_user

    @post = posts(:one)
    @comment_params = { content: Faker::Lorem.paragraph_by_chars(number: 50) }
    @another_comment_params = { content: Faker::Lorem.paragraph_by_chars(number: 50) }

    @comment = PostComment.create!(@comment_params.merge(user: @user, post: @post))
  end

  teardown do
    Rails.cache.clear
  end

  test '#create as User success' do
    sign_in @user

    assert_difference('PostComment.count') do
      post post_comments_url(@post), params: { post_comment: @comment_params }
    end

    assert_redirected_to @post
  end

  test '#create as User failed' do
    sign_in @user

    assert_no_difference('PostComment.count') do
      post post_comments_url(@post), params: { post_comment: { content: nil } }
    end

    assert_response :unprocessable_entity
  end

  test '#create as Guest' do
    assert_no_difference('PostComment.count') do
      post post_comments_url(@post), params: { post_comment: @comment_params }
    end

    assert_redirected_to new_user_session_path
  end

  test '#edit as authorized User' do
    sign_in @user

    get edit_post_comment_url(@post, @comment)

    assert_response :success
  end

  test '#edit as unauthorized User' do
    sign_in @another_user

    get edit_post_comment_url(@post, @comment)

    assert_redirected_to root_path
  end

  test '#edit as Guest' do
    get edit_post_comment_url(@post, @comment)

    assert_redirected_to new_user_session_url
  end

  test '#update as authorized User success' do
    sign_in @user

    patch post_comment_url(@post, @comment), params: { post_comment: @another_comment_params }

    assert_redirected_to @post

    @comment.reload
    assert { @another_comment_params[:content] == @comment.content }
  end

  test '#update as User failed' do
    sign_in @user

    patch post_comment_url(@post, PostComment.first), params: { post_comment: { content: nil } }

    assert_response :unprocessable_entity
  end

  test '#update as unauthorized User' do
    sign_in @another_user

    patch post_comment_url(@post, @comment), params: { post_comment: @another_post_comment_params }

    assert_redirected_to root_path

    @comment.reload
    assert { @another_comment_params[:content] != @comment.content }
  end

  test '#update as Guest' do
    patch post_comment_url(@post, @comment), params: { post_comment: @post_comment_params }

    assert_redirected_to new_user_session_url
  end
end
