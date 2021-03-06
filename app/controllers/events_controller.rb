require 'csv'

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :require_admin_for_event, except: :change_event
  # GET /events
  # GET /events.json
  def index
    @events = current_user.admin_for_events.map{ |afe| afe.event }
  end

  def change_event
    event = Event.find(params[:event_id])
    if(event&.id != current_user.actual_event.id)
      current_user.actual_event = event
      current_user.save!
    end
    redirect_to root_path
  end

  def get_participants
    respond_to do |format|
      format.html
      format.csv { send_data Event.get_participants_in_csv(params[:event_id]), filename: "participants-#{Date.today}.csv" }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.add_homepage
    @event.add_invitation_email
    @event.tickets_left = @event.participants

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name,:fullname,:fullname, :site,
                                    :support_mail,:participants, :price,
                                    :reserve_price, :ideal_price,:start_date,
                                    :end_date, :venue, :venue_location, :monkeys,:status,:tickets_left)
    end

end
