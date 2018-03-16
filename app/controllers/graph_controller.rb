class GraphController < ApplicationController

  def index
  end

  def data
    respond_to do |format|
      format.json {
        render :json => [55,120,33,450,500]
      }
    end
  end

end