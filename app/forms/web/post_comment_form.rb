# frozen_string_literal: true

class Web::PostCommentForm < PostComment
  include ActiveFormModel

  permit :content, :parent_id
end
