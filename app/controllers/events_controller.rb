class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def displayBySport
    @events = Event.findBySport(params[:id])
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.findOne(params[:id])
  end

  def update
    @event = Event.findOne(params[:id])
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
