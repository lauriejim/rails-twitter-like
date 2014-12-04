class EventsController < ApplicationController

  def displayAll
    @events = Event.all
  end

  def displayBySport
    @events = Event.findBySport(params[:id])
  end

  def display
    @events = Event.findOne(params[:id])
  end
end
