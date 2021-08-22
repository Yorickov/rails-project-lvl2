# frozen_string_literal: true

# == Schema Information
#
# Table name: post_categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class PostCategoryTest < ActiveSupport::TestCase
  self.use_transactional_tests = true

  def setup
    @post_category = post_categories(:sport)
    @presence_message = "can't be blank"
  end

  test 'valid' do
    assert @post_category.valid?
  end

  test 'invalid without name' do
    @post_category.name = nil

    assert_not @post_category.valid?
    assert_equal [@presence_message], @post_category.errors[:name]
  end

  test '#posts' do
    assert_equal 1, @post_category.posts.size
  end
end
