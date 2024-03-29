# frozen_string_literal: true

require 'test_helper'

class Web::Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    @comment = post_comments(:one)
    @comment_params = { content: Faker::Lorem.paragraph_by_chars(number: 50) }
  end

  test '#create' do
    sign_in @user

    post post_comments_url(@post), params: { post_comment: @comment_params }

    assert_redirected_to @post

    comment = PostComment.find_by(@comment_params)
    assert { comment }
  end

  test '#create without content' do
    sign_in @user

    @comment_params[:content] = nil

    post post_comments_url(@post), params: { post_comment: @comment_params }

    assert_response :unprocessable_entity

    comment = PostComment.find_by(@comment_params)
    assert { !comment }
  end

  test '#update' do
    sign_in @user

    patch post_comment_url(@post, @comment), params: { post_comment: @comment_params }

    assert_redirected_to @post

    @comment.reload
    assert { @comment_params[:content] == @comment.content }
  end
end
