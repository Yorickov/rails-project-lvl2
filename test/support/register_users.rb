# frozen_string_literal: true

module RegisterUsers
  def register_user_and_another_user
    @user = users(:one)
    @user.update!(confirmed_at: Time.current)
    @another_user = users(:two)
    @another_user.update!(confirmed_at: Time.current)
  end
end
