class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]
  before_action :require_admin_login


  # GET /pages/new
  def new
    @page = Page.new
    @page.event = Event.find(params[:event])
  end


  def edit
  end

  def create
    @page = Page.new(event_params)

    respond_to do |format| if @page.save
        format.html { redirect_to @page.event, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update(event_params)
        format.html { redirect_to @page.event, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to @page.event, notice: 'Página borrada correctamente' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:page).permit(:path,:content,:event_id)
    end

end
