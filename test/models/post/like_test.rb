# frozen_string_literal: true

# == Schema Information
#
# Table name: post_likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_post_likes_on_post_id              (post_id)
#  index_post_likes_on_post_id_and_user_id  (post_id,user_id) UNIQUE
#  index_post_likes_on_user_id              (user_id)
#
# Foreign Keys
#
#  post_id  (post_id => posts.id)
#  user_id  (user_id => users.id)
#
require 'test_helper'

class Post::LikeTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:user)
    # FIXME: inverse not needed?
    should belong_to(:post).inverse_of(:likes)
  end

  context 'validations' do
    should validate_uniqueness_of(:post).scoped_to(:user_id)
  end
end
