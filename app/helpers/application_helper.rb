# frozen_string_literal: true

module ApplicationHelper
  def format_creation_time(time)
    time_ago_in_words(time.in_time_zone)
  end
end
