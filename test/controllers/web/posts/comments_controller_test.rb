# frozen_string_literal: true

require 'test_helper'

class Web::Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_comment = post_comments(:one)
    @post = posts(:one)
    @post_comment_params = { content: @post_comment.content }
    @another_post_comment = post_comments(:two)
  end

  test '#create as User success' do
    sign_in users(:one)

    assert_difference('Post::Comment.count') do
      post post_comments_url(@post_comment.post), params: { post_comment: @post_comment_params }
    end

    assert_redirected_to @post_comment.post
  end

  test '#create as User failed' do
    sign_in users(:one)

    @post_comment_params = { content: nil }

    assert_no_difference('Post::Comment.count') do
      post post_comments_url(@post_comment.post), params: { post_comment: @post_comment_params }
    end

    assert_response :unprocessable_entity
  end

  test '#create as Guest' do
    assert_no_difference('Post::Comment.count') do
      post post_comments_url(@post_comment.post), params: { post_comment: @post_comment_params }
    end

    assert_redirected_to new_user_session_path
  end

  test '#edit as authorized User' do
    sign_in users(:two)

    get edit_post_comment_url(@post, @post_comment)

    assert_response :success
  end

  test '#edit as unauthorized User' do
    sign_in users(:one)

    get edit_post_comment_url(@post, @post_comment)

    assert_redirected_to root_path
  end

  test '#edit as Guest' do
    get edit_post_comment_url(@post, @post_comment)

    assert_redirected_to new_user_session_url
  end

  test '#update as authorized User success' do
    sign_in users(:two)
    patch post_comment_url(@post, @post_comment), params: { post_comment: { content: @another_post_comment.content } }

    assert_redirected_to @post

    @post_comment.reload
    assert_equal @another_post_comment.content, @post_comment.content
  end

  test '#update as User failed' do
    sign_in users(:two)
    @post_comment_params[:content] = nil

    patch post_comment_url(@post, @post_comment), params: { post_comment: @post_comment_params }

    assert_response :unprocessable_entity
  end

  test '#update as unauthorized User' do
    sign_in users(:one)

    patch post_comment_url(@post, @post_comment), params: { post_comment: { content: @another_post_comment.content } }
    assert_redirected_to root_path

    @post_comment.reload
    assert_not_equal @another_post_comment.content, @post_comment.content
  end

  test '#update as Guest' do
    patch post_comment_url(@post, @post_comment), params: { post_comment: @post_comment_params }

    assert_redirected_to new_user_session_url
  end
end
