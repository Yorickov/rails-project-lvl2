# frozen_string_literal: true

require 'test_helper'

class Web::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    @post_params = {
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph_by_chars(number: 400),
      post_category_id: @post.post_category_id
    }
  end

  test '#show' do
    get post_url(@post)

    assert_response :success
  end

  test '#new' do
    sign_in @user

    get new_post_url

    assert_response :success
  end

  test '#create' do
    sign_in @user

    post posts_url, params: { post: @post_params }

    assert_response :redirect

    post = Post.find_by(@post_params)
    assert { post }
  end

  test '#create without title' do
    sign_in @user

    @post_params[:title] = nil

    post posts_url, params: { post: @post_params }

    assert_response :unprocessable_entity

    post = Post.find_by(@post_params)
    assert { !post }
  end

  test '#edit' do
    sign_in @user

    get edit_post_url(@post)

    assert_response :success
  end

  test '#update' do
    sign_in @user

    patch post_url(@post), params: { post: @post_params }

    assert_redirected_to @post

    @post.reload
    assert { @post_params[:body] == @post.body }
  end

  test '#destroy' do
    sign_in @user

    delete post_url(@post)

    assert_redirected_to root_path

    post = Post.find_by(id: @post.id)
    assert { !post }
  end
end
