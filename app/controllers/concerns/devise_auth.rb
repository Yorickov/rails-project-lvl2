# frozen_string_literal: true

module DeviseAuth
  def after_sign_in_path_for(_user)
    flash['notice'] = t('welcome', user: current_user.email)
    root_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    flash['notice'] = t('goodbye')
    request.referer
  end
end
