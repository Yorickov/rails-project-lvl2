# frozen_string_literal: true

class Web::Post::CommentForm < PostComment
  include ActiveFormModel

  permit :content, :parent_id
end
