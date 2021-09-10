# frozen_string_literal: true

module ApplicationHelper
  DEFAULT_PREVIEW_BODY_LENGTH = 300

  def time_ago(time)
    time_ago_in_words(time.in_time_zone)
  end

  def footer_project_name
    "&copy; #{Time.current.year} #{t('.project')}".html_safe # rubocop:disable Rails:OutputSafety
  end

  def preview_of(post_body, length = DEFAULT_PREVIEW_BODY_LENGTH)
    post_body.truncate(length)
  end

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
