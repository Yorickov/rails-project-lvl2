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
  context 'associations' do
    should belong_to(:user)
    should belong_to(:post_category).class_name('PostCategory')
    should have_many(:comments).dependent(:destroy)
    should have_many(:likes).dependent(:destroy)
  end

  context 'validations' do
    should validate_presence_of(:title)
    should validate_presence_of(:body)
    should validate_length_of(:body).is_at_least(50)
  end
end
