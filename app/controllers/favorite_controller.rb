class FavoriteController < ApplicationController
  before_action :require_login

  def add_favorite
    current_user.favorites.append(User.find(params[:favorite_id]))
  end

  def remove_favorite
    current_user.favorites.delete(User.find(params[:favorite_id]))
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.permit(:favorite_id)
  end
end
