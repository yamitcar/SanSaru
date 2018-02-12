class AgileRelationsController < ApplicationController
  before_action :set_agile_relation, only: [:show, :edit, :update, :destroy]

  # GET /agile_relations
  # GET /agile_relations.json
  def index
    @agile_relations = AgileRelation.all
  end

  # GET /agile_relations/1
  # GET /agile_relations/1.json
  def show
  end

  # GET /agile_relations/new
  def new
    @agile_relation = AgileRelation.new
  end

  # GET /agile_relations/1/edit
  def edit
  end

  # POST /agile_relations
  # POST /agile_relations.json
  def create
    @agile_relation = AgileRelation.new(agile_relation_params)

    respond_to do |format|
      if @agile_relation.save
        format.html { redirect_to @agile_relation, notice: 'Agile relation was successfully created.' }
        format.json { render :show, status: :created, location: @agile_relation }
      else
        format.html { render :new }
        format.json { render json: @agile_relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agile_relations/1
  # PATCH/PUT /agile_relations/1.json
  def update
    respond_to do |format|
      if @agile_relation.update(agile_relation_params)
        format.html { redirect_to @agile_relation, notice: 'Agile relation was successfully updated.' }
        format.json { render :show, status: :ok, location: @agile_relation }
      else
        format.html { render :edit }
        format.json { render json: @agile_relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agile_relations/1
  # DELETE /agile_relations/1.json
  def destroy
    @agile_relation.destroy
    respond_to do |format|
      format.html { redirect_to agile_relations_url, notice: 'Agile relation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agile_relation
      @agile_relation = AgileRelation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agile_relation_params
      params.require(:agile_relation).permit(:name)
    end
end
