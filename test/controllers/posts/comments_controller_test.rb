# frozen_string_literal: true

require 'test_helper'

class Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_comment = post_comments(:one)
    @post_comment_params = { content: @post_comment.content }
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

    assert_redirected_to new_user_session_url
  end
end
