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
  self.use_transactional_tests = true

  def setup
    @post = posts(:one)
    @presence_message = "can't be blank"
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
    assert_equal [@presence_message], @post.errors[:body]
  end

  test '#post_category' do
    assert_equal 'sport', @post.post_category.name
  end

  test '#user' do
    assert_equal 'two@email.com', @post.user.email
  end

  test '#post_comments' do
    assert_equal 1, @post.post_comments.size
  end
end
