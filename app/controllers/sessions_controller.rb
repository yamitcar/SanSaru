class SessionsController < Devise::SessionsController
  def create
    super do |user|
      user.actual_event = Event.find(params[:user][:actual_event_id])
      user.save!
    end
  end
end
