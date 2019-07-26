class CustomEmailsController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :require_admin_login


  # GET /pages/new
  def new
    @custom_email = CustomEmail.new
    @custom_email.event = Event.find(params[:event])
  end


  def edit
  end

  def create
    @custom_email = CustomEmail.new(event_params)

    respond_to do |format| if @custom_email.save
        format.html { redirect_to @custom_email.event, notice: 'Email was successfully created.' }
        format.json { render :show, status: :created, location: @custom_email }
      else
        format.html { render :new }
        format.json { render json: @custom_email.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @custom_email.update(custom_email_params)
        message = 'Email actualizado correctamente'
        if(params[:commit] == "Guardar y enviar una prueba a los copiados")
          if(@custom_email.name == :notify_invitation.to_s)
              message = 'Email actualizado y enviado, fijate en tu buzón'
            AocMailer.notify_invitation(current_user, current_user, true).deliver_later
          end
        end
        format.html { redirect_to @custom_email.event, notice: message }
        format.json { render :show, status: :ok, location: @custom_email }
      else
        format.html { render :edit }
        format.json { render json: @custom_email.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @custom_email.destroy
    respond_to do |format|
      format.html { redirect_to @custom_email.event, notice: 'Página borrada correctamente' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @custom_email = CustomEmail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def custom_email_params
      params.require(:custom_email).permit(:copy_to,:template,:name,:event_id)
    end

end
