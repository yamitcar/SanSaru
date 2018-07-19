class GraphController < ApplicationController
  # before_action :require_login
  layout "graph"

  def index; end

  def data
    trees = Invitation.build_invitation_trees

    respond_to do |format|
      format.json do
        render json: trees
      end
    end
  end
end
