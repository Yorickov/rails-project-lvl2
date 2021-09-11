# frozen_string_literal: true

class Web::PostForm < Post
  include ActiveFormModel

  permit :title, :body, :post_category_id
end
