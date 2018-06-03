class DivipolaController < ApplicationController


  def states
    data = CS.get(params[:country])
    render json: data.to_json
  end

  def cities
    data = CS.get(params[:country], params[:state])
    render json: data.to_json
  end
end