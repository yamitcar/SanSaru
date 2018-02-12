class AgilesController < ApplicationController
  before_action :set_agile, only: [:show, :edit, :update, :destroy]

  # GET /agiles
  # GET /agiles.json
  def index
    @agiles = Agile.all
  end

  # GET /agiles/1
  # GET /agiles/1.json
  def show
  end

  # GET /agiles/new
  def new
    @agile = Agile.new
  end

  # GET /agiles/1/edit
  def edit
  end

  # POST /agiles
  # POST /agiles.json
  def create
    @agile = Agile.new(agile_params)

    respond_to do |format|
      if @agile.save
        format.html { redirect_to @agile, notice: 'Agile was successfully created.' }
        format.json { render :show, status: :created, location: @agile }
      else
        format.html { render :new }
        format.json { render json: @agile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agiles/1
  # PATCH/PUT /agiles/1.json
  def update
    respond_to do |format|
      if @agile.update(agile_params)
        format.html { redirect_to @agile, notice: 'Agile was successfully updated.' }
        format.json { render :show, status: :ok, location: @agile }
      else
        format.html { render :edit }
        format.json { render json: @agile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agiles/1
  # DELETE /agiles/1.json
  def destroy
    @agile.destroy
    respond_to do |format|
      format.html { redirect_to agiles_url, notice: 'Agile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agile
      @agile = Agile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agile_params
      params.require(:agile).permit(:name)
    end
end
