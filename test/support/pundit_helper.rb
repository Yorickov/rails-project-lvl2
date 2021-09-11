# frozen_string_literal: true

module PunditHelper
  def assert_permit(user, record, action)
    msg = "User #{user.inspect} should be permitted to #{action} #{record}, but isn't permitted"
    assert permit(user, record, action), msg
  end

  def refute_permit(user, record, action)
    msg = "User #{user.inspect} should NOT be permitted to #{action} #{record}, but is permitted"
    assert_not permit(user, record, action), msg
  end

  def permit(user, record, action)
    klass = self.class.to_s.gsub(/Test/, '')
    klass.constantize.new(user, record).public_send("#{action}?")
  end
end
