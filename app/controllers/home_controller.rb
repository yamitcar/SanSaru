class HomeController < ApplicationController
  before_action :require_login
  helper_method :can_invite?

  def can_invite?(current_user)
    unless current_user.actual_event.is_invitation_period_open?
      return false, 'El período de selección está cerrado'
    end

    unless current_user.actual_event.has_invitations?
      return false, 'Lo sentimos, ya no tenemos invitaciones disponibles :('
    end

    unless current_user.has_invitation?
      return false, 'No tienes invitaciones disponibles'
    end

    return false, 'Esta persona ya fue invitada' if @user.was_invite?

    unless current_user.was_pay?
      return false, 'Debes pagar tu entrada antes de poder seleccionar a otras personas.'
    end

    [true, '']
  end

  def show
    @user = if params[:postulado]
              User.find(params[:postulado])
            else
              current_user
            end
  end

  def edit
    @user = current_user
    @profile = @user.profile
  end

  def invite
    invited = User.find(params[:invited])
    error = current_user.invite invited
    respond_to do |format|
      if error
        format.html { redirect_to "/home?postulado=#{invited.id}", notice: error }
      else
        # Tell the AocMailer to send a welcome email after save
        AocMailer.notify_invitation(invited, current_user).deliver_later
        name = "#{invited.name} #{invited.lastname}"
        format.html { redirect_to '/profiles', notice: "Has invitado correctamente a #{name}." }
      end
    end
  end

  # GET /profiles/new
  def new
    @aoc_name = helpers.aoc_name
    @profile = current_user.profile || Profile.new
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_user
    @profile.event = current_user.actual_event
    respond_to do |format|
      if @profile.save
        format.html { redirect_to '/home', notice: 'Profile was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      @profile = current_user.profile
      if @profile.update(profile_params)
        format.html { redirect_to '/home', notice: 'Profile was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  #  def has_invitation? user_id
  # end

  # helper_method :has_invitation?

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(:phonenumber, :telegram, :country, :city, :state, :first_time,
                                    :expectancy, :agile_id, :agile_description, :hobbies, :bring, :proposal,
                                    :bio, :agileRelation_id, :gender_id, :size_id)
  end
end
