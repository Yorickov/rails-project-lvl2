# frozen_string_literal: true

module RegisterUsers
  def register_user_and_another_user
    @user = users(:one)
    @another_user = users(:two)
  end
end
