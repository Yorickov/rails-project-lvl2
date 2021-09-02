# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id               :bigint           not null, primary key
#  body             :text             not null
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  post_category_id :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_posts_on_post_category_id  (post_category_id)
#  index_posts_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_category_id => post_categories.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class PostTest < ActiveSupport::TestCase
  setup do
    @post = posts(:one)
    @presence_message = "can't be blank"
    @length_message = 'is too short (minimum is 50 characters)'
  end

  test 'valid' do
    assert @post.valid?
  end

  test 'invalid without title' do
    @post.title = nil

    assert_not @post.valid?
    assert_equal [@presence_message], @post.errors[:title]
  end

  test 'invalid without body' do
    @post.body = nil

    assert_not @post.valid?
    assert_equal [@presence_message, @length_message], @post.errors[:body]
  end

  test 'invalid with body less than 50 chars' do
    @post.body = Faker::Lorem.paragraph_by_chars(number: 49)

    assert_not @post.valid?
    assert_equal [@length_message], @post.errors[:body]
  end

  test '#post_category' do
    assert_equal 'sport', @post.post_category.name
  end

  test '#user' do
    assert_equal 'two@email.com', @post.user.email
  end

  test '#post_comments' do
    assert_equal 1, @post.comments.size
  end
end
