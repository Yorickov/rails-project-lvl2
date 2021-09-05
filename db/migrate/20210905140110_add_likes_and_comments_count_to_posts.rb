# frozen_string_literal: true

class AddLikesAndCommentsCountToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :likes_count, :integer
    add_column :posts, :comments_count, :integer
  end
end
