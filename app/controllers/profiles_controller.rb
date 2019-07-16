require 'will_paginate/array'

class ProfilesController < ApplicationController
  before_action :set_profile, only: [:destroy]
  before_action :require_login

  def index
    # TODO optimize this query https://stackoverflow.com/questions/20942482/rails-find-using-where-in-one-to-many-relation

    @profiles = Profile.where.not(user_id: current_user.id).where(event_id: current_user.actual_event.id)
                   .order('organizer DESC, created_at ASC').paginate(page: params[:page], per_page: 10)
  end

  def favorites
    @postulados = current_user.favorites.paginate(page: params[:page], per_page: 10)
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(:residence, :first_time, :expectancy, :agile_id, :agile_description,
                                    :hobbies, :bring, :proposal, :bio, :agileRelation_id, :gender_id, :size_id)
  end
end
