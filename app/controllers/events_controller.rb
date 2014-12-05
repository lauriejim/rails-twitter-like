class EventsController < ApplicationController

  def index
    @events = Event.all
    render :layout => "admin"
  end

  def display_by_sport
    @events = Event.find_by_sport(params[:id])
    @sport = Sport.find_one(params[:id])
    render :layout => "admin"
  end

  def show
    begin
      @event = Event.find_one(params[:id])
    rescue
      redirect_to events_path
    end
    render :layout => "admin"
  end

  def new
    @event = Event.new
    render :layout => "admin"
  end

  def edit
    begin
      @event = Event.find_one(params[:id])
    rescue
      redirect_to edit_event_path
    end
    render :layout => "admin"
  end

  def update
    begin
      @event = Event.find_one(params[:id])
    rescue
      redirect_to edit_event_path
    end

    @event.update(event_params)

    redirect_to edit_event_path(@event)
    render :layout => "admin"
  end

  def create
    @event = Event.create(event_params)
    @event.save!

    redirect_to new_event_path
    render :layout => "admin"
  end

  private
    def event_params
      params.require(:event).permit(:title, :cover, :likes, :description, :adresse, :sport_id)
    end

end
