class ApplicationController < ActionController::Base
  # layout "application_v2"
  before_action :set_paper_trail_whodunnit
  # protect_from_forgery with: :exception
  protect_from_forgery prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name lastname terms_of_service])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name lastname])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[:email password actual_event])
  end

  def after_sign_in_path_for(_user)
    '/home'
  end

  def require_login
    unless user_signed_in?
      # TODO: flash doesnt work
      flash[:notice] = 'debes estar logueado para ver esto'
      redirect_to new_user_session_path
    end
  end

  def require_admin_login
    unless (user_signed_in? and current_user.admin)
      flash[:error] = 'no tienes acceso a esta pagina'
      redirect_to(:home)
    end
  end
end
