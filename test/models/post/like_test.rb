# frozen_string_literal: true

# == Schema Information
#
# Table name: post_likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_post_likes_on_post_id              (post_id)
#  index_post_likes_on_post_id_and_user_id  (post_id,user_id) UNIQUE
#  index_post_likes_on_user_id              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class Post::LikeTest < ActiveSupport::TestCase
  setup do
    @like = post_likes(:one)
  end

  test '#post' do
    assert_equal 'one', @like.post.title
  end

  test '#user' do
    assert_equal 'one@email.com', @like.user.email
  end

  test '#uniqueness' do
    like = Post::Like.new(post: posts(:one), user: users(:one))
    assert_not like.valid?
    assert_equal ['has already been taken'], like.errors[:post]
  end
end
