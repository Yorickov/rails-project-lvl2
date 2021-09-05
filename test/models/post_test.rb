# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  body             :text             not null
#  likes_count      :integer
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  post_category_id :integer          not null
#  user_id          :integer          not null
#
# Indexes
#
#  index_posts_on_post_category_id  (post_category_id)
#  index_posts_on_user_id           (user_id)
#
# Foreign Keys
#
#  post_category_id  (post_category_id => post_categories.id)
#  user_id           (user_id => users.id)
#
require 'test_helper'

class PostTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:creator).class_name('User').with_foreign_key(:user_id).inverse_of(:posts)
    should belong_to(:post_category)
    should have_many(:comments).class_name('Post::Comment').inverse_of(:post).dependent(:destroy)
    should have_many(:likes).class_name('Post::Like').inverse_of(:post).dependent(:destroy)
  end

  context 'validations' do
    should validate_presence_of(:title)
    should validate_presence_of(:body)
    should validate_length_of(:body).is_at_least(50)
  end
end
