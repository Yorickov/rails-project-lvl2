# frozen_string_literal: true

class PostCommentPolicy < ApplicationPolicy
  def update?
    author?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def author?
    record.user == user
  end
end
