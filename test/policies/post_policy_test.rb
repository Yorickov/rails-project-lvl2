# frozen_string_literal: true

require 'test_helper'

class PostPolicyTest < ActiveSupport::TestCase
  setup do
    @author = users(:one)
    @no_author = users(:two)
    @post = posts(:one)
  end

  def test_edit_author
    assert_permit @author, @post, :edit
  end

  def test_update_author
    assert_permit @author, @post, :update
  end

  def test_destroy_author
    assert_permit @author, @post, :destroy
  end

  def test_edit_no_author
    refute_permit @no_author, @post, :edit
  end

  def test_update_no_author
    refute_permit @no_author, @post, :update
  end

  def test_destroy_no_author
    refute_permit @no_author, @post, :destroy
  end
end
