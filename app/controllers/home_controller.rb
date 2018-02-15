class HomeController < ApplicationController

  def show
    unless user_signed_in?
      redirect_to new_user_session_path
    end

    @user = current_user
  end

end
