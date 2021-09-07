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
class PostComment < ApplicationRecord
  has_ancestry

  belongs_to :user
  belongs_to :post, counter_cache: :comments_count

  validates :content, presence: true, length: { maximum: 100 }

  def to_s
    content
  end

  def errors_with?(comment)
    errors.any? &&
      eql?(comment) || child_of?(comment) && new_record?
  end
end
