# frozen_string_literal: true

# == Schema Information
#
# Table name: post_comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_post_comments_on_post_id  (post_id)
#  index_post_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class PostCommentTest < ActiveSupport::TestCase
  self.use_transactional_tests = true

  def setup
    @post_comment = post_comments(:one)
    @presence_message = "can't be blank"
    @wrong_length = 'is too long (maximum is 100 characters)'
  end

  test 'valid' do
    assert @post_comment.valid?
  end

  test 'invalid without comment' do
    @post_comment.content = nil

    assert_not @post_comment.valid?
    assert_equal [@presence_message], @post_comment.errors[:content]
  end

  test 'invalid wrong length' do
    @post_comment.content = @post_comment.content * 100

    assert_not @post_comment.valid?
    assert_equal [@wrong_length], @post_comment.errors[:content]
  end

  test '#post' do
    assert_equal 'two', @post_comment.post.title
  end

  test '#user' do
    assert_equal 'two@email.com', @post_comment.user.email
  end
end
