# frozen_string_literal: true

require 'test_helper'

class Web::Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    @comment = PostComment.create!(user: @user, post: @post, content: Faker::Lorem.paragraph_by_chars(number: 50))
    @comment_params = { content: Faker::Lorem.paragraph_by_chars(number: 50) }
  end

  test '#create' do
    sign_in @user

    assert_difference('PostComment.count') do
      post post_comments_url(@post), params: { post_comment: @comment_params }
    end

    comment = PostComment.find_by(@comment_params)
    assert { comment }
  end

  test '#create without content' do
    sign_in @user

    assert_no_difference('PostComment.count') do
      post post_comments_url(@post), params: { post_comment: { content: nil } }
    end

    assert_response :unprocessable_entity
  end

  test '#update' do
    sign_in @user

    patch post_comment_url(@post, @comment), params: { post_comment: @comment_params }

    assert_redirected_to @post

    @comment.reload
    assert { @comment_params[:content] == @comment.content }
  end
end
