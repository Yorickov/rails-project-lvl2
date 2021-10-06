# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id               :integer          not null, primary key
#  body             :text             not null
#  comments_count   :integer
#  likes_count      :integer
#  title            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  creator_id       :integer          not null
#  post_category_id :integer          not null
#
# Indexes
#
#  index_posts_on_creator_id        (creator_id)
#  index_posts_on_post_category_id  (post_category_id)
#
# Foreign Keys
#
#  creator_id        (creator_id => users.id)
#  post_category_id  (post_category_id => post_categories.id)
#
class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User', inverse_of: :posts
  belongs_to :post_category
  has_many :comments, class_name: 'PostComment', inverse_of: :post, dependent: :destroy
  has_many :likes, class_name: 'PostLike', inverse_of: :post, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 50 }

  paginates_per 3

  def to_s
    title
  end
end
