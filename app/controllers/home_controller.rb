class HomeController < ApplicationController

  before_action :require_login

  def show
    if params[:postulado]
      @user =  User.find(params[:postulado])
    else
      @user = current_user
    end
  end

  def edit
    @user = current_user
    @profile = @user.profile
  end

  def invite
    invitation = Invitation.find_by(user_id: current_user.id)
    if invitation
      invited = User.find(params[:invited])
      if invitation.invited_one == nil
        invitation.invited_one = invited
        invitation.one_on = Time.now
      elsif invitation.invited_two == nil
        invitation.invited_two = invited
        invitation.two_on = Time.now
      else
        error = "Ya invitaste a dos personas"
      end
      if invitation.save
        cupos = Config.find_by(name: :cupos)
        value = cupos.value.to_i
        if value.to_i > 0
          Invitation.create!(user_id: invited.id)
          value -= 1
          cupos.value = value.to_s
          cupos.save!
        else
          "Lo sentimos, ya no tenemos cupos disponibles :'("
        end
      else
        error = "Algo malio sal, intentalo de nuevo"
      end
    else
      error = "No tienes permitido invitar a nadie aún"
    end

    #TODO mostrar cantidad de invitaciones restantes
    #TODO validar que se muestr el boton si hay invitaciones, si no, no
    # TODO arreglar este spagueti

    respond_to do |format|
      if error
        format.html { redirect_to "/home?postulado=#{params[:invited]}", notice: error }
      else
        format.html { redirect_to '/profiles', notice: "Has invitado correctamente a #{invitation.invited_one.name} #{invitation.invited_one.lastname}." }
      end

    end


  end

  # GET /profiles/new
  def new
    @profile = current_user.profile || Profile.new
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    respond_to do |format|
      if @profile.save
        current_user.profile = @profile
        current_user.save!
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

  def has_invitation? user_id
    invitation = Invitation.find_by(user_id: user_id)
    if invitation
      return (invitation.invited_one==nil or invitation.invited_two == nil)
    end
    return false
  end

  helper_method :has_invitation?

  private

  def require_login
    unless user_signed_in?
      #TODO flash doesnt work
      flash[:error] = "debes estar logueado para ver esto"
      redirect_to new_user_session_path
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(:residence, :first_time, :expectancy, :agile_id, :agile_description, :hobbies, :bring, :proposal, :bio, :agileRelation_id, :gender_id, :size_id)
  end

end
