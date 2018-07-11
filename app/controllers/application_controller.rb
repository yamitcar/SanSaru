class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit
  #protect_from_forgery with: :exception
  protect_from_forgery prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :lastname])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :lastname])
  end

  def after_sign_in_path_for(user)
    '/home'
  end

  def require_login
    unless user_signed_in?
      #TODO flash doesnt work
      flash[:error] = "debes estar logueado para ver esto"
      redirect_to new_user_session_path
    end
  end
end
