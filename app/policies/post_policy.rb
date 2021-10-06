# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def edit?
    author?
  end

  def update?
    author?
  end

  def destroy?
    author?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def author?
    record.creator == user
  end
end
