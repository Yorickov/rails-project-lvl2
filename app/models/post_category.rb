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
class PostCategory < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, presence: true
end
