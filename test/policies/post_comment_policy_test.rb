# frozen_string_literal: true

require 'test_helper'

class PostCommentPolicyTest < ActiveSupport::TestCase
  setup do
    @author = users(:one)
    @no_author = users(:two)
    @comment = PostComment.create(
      user: @author,
      post: posts(:one),
      content: Faker::Lorem.paragraph_by_chars(number: 50)
    )
  end

  def test_update_author
    assert_permit @author, @comment, :update
  end

  def test_update_no_author
    refute_permit @no_author, @comment, :update
  end
end
