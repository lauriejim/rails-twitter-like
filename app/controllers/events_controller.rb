class EventsController < ApplicationController

  def displayAll
    @events = Event.all
  end

  def displayBySport
    @events = Event.findBySport(params[:id])
  end

  def display(event_id)
    @events = Event.findOne(event_id)
  end
end
