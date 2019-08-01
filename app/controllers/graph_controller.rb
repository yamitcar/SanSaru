class GraphController < ApplicationController
  # before_action :require_login
  layout "graph"

  def index; end

  def data
    event = Event.find_by_home_path(params['event_home'])
    trees = Invitation.build_invitation_trees(event)

    respond_to do |format|
      format.json do
        render json: trees
      end
    end
  end
end
