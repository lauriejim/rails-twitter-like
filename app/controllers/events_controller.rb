class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def displayBySport
    @events = Event.findBySport(params[:id])
  end

  def show
    begin 
      @event = Event.findOne(params[:id])
    rescue 
      redirect_to events_path
    end
  end

  def new
    @event = Event.new
  end

  def edit
    begin 
      @event = Event.findOne(params[:id])
    rescue 
      redirect_to edit_event_path
    end
  end

  def update
    begin 
      @event = Event.findOne(params[:id])
    rescue 
      redirect_to edit_event_path
    end

    @event.update(event_params)

    redirect_to edit_event_path(@event)
  end
  
  def create
    @event = Event.create(event_params)
    @event.save!

    redirect_to new_event_path
  end

  private
    def event_params
      params.require(:event).permit(:title, :cover, :likes, :description, :adresse, :sport_id)
    end

end
