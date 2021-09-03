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
  context 'associations' do
    should have_many(:posts).dependent(:destroy)
  end

  context 'validations' do
    should validate_presence_of(:name)
  end
end
