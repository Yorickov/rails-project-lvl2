# frozen_string_literal: true

module Posts::CommentsHelper
  def nested_comments(comments)
    comments.map do |comment, sub_comment|
      if comment.is_root?
        render('web/posts/comments/root', comment: comment) { tag.div { nested_comments(sub_comment) } }
      else
        render('web/posts/comments/nested', comment: comment) + tag.div(class: 'ms-4') { nested_comments(sub_comment) }
      end
    end.join.html_safe # rubocop:disable Rails/OutputSafety
  end
end
