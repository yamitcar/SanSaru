class FavoriteController < ApplicationController
  before_action :require_login

  def add_favorite
    favorite = Favorite.new(user_id: current_user.id,
                          favorite_user_id: params[:favorite_id],
                          event_id: current_user.actual_event.id)
    current_user.favorites.append(favorite)
  end

  def remove_favorite
    Favorite.where(favorite_user_id: params[:favorite_id])
                   .where(event_id: current_user.actual_event.id)
                   .where(user_id: current_user.id).first.delete
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.permit(:favorite_id)
  end
end
