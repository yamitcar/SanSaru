class GendersController < ApplicationController
  before_action :set_gender, only: [:show, :edit, :update, :destroy]

  # GET /genders
  # GET /genders.json
  def index
    @genders = Gender.all
  end

  # GET /genders/1
  # GET /genders/1.json
  def show
  end

  # GET /genders/new
  def new
    @gender = Gender.new
  end

  # GET /genders/1/edit
  def edit
  end

  # POST /genders
  # POST /genders.json
  def create
    @gender = Gender.new(gender_params)

    respond_to do |format|
      if @gender.save
        format.html { redirect_to @gender, notice: 'Gender was successfully created.' }
        format.json { render :show, status: :created, location: @gender }
      else
        format.html { render :new }
        format.json { render json: @gender.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /genders/1
  # PATCH/PUT /genders/1.json
  def update
    respond_to do |format|
      if @gender.update(gender_params)
        format.html { redirect_to @gender, notice: 'Gender was successfully updated.' }
        format.json { render :show, status: :ok, location: @gender }
      else
        format.html { render :edit }
        format.json { render json: @gender.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /genders/1
  # DELETE /genders/1.json
  def destroy
    @gender.destroy
    respond_to do |format|
      format.html { redirect_to genders_url, notice: 'Gender was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gender
      @gender = Gender.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gender_params
      params.require(:gender).permit(:name)
    end
end
