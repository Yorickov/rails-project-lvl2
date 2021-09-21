# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  around_action :switch_locale

  def default_url_options
    I18n.locale == I18n.default_locale ? {} : { lang: I18n.locale }
  end

  # TODO: precise path
  def after_sign_in_path_for(_user)
    flash['notice'] = t('welcome', user: current_user.email)
    root_path
  end

  def after_sign_out_path_for(_resource_or_scope)
    flash['notice'] = t('goodbye')
    request.referer
  end

  private

  def switch_locale(&action)
    locale = (I18n.locale_available?(params[:lang]) && params[:lang]) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    redirect_to (request.referer || root_path),
                alert: t("#{policy_name}.#{exception.query}", scope: 'pundit', default: :default)
  end
end
