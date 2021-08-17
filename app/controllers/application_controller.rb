# frozen_string_literal: true

class ApplicationController < ActionController::Base
  around_action :switch_locale

  def default_url_options
    I18n.locale == I18n.default_locale ? {} : { lang: I18n.locale }
  end

  private

  def switch_locale(&action)
    locale = I18n.locale_available?(params[:lang]) && params[:lang] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
