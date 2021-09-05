# frozen_string_literal: true

# == Schema Information
#
# Table name: post_comments
#
#  id         :integer          not null, primary key
#  ancestry   :string
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_post_comments_on_ancestry  (ancestry)
#  index_post_comments_on_post_id   (post_id)
#  index_post_comments_on_user_id   (user_id)
#
# Foreign Keys
#
#  post_id  (post_id => posts.id)
#  user_id  (user_id => users.id)
#
require 'test_helper'

class PostCommentTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:user)
    should belong_to(:post)
  end

  context 'validations' do
    should validate_presence_of(:content)
    should validate_length_of(:content).is_at_most(100)
  end
end
