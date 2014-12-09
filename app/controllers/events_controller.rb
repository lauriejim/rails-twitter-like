class EventsController < ApplicationController

  def index
    @events = Event.all
    render :layout => "admin"
  end

  def display_by_sport
    begin
      @events = Event.find_by_sport(params[:id])
      @sport = Sport.find_one(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to events_path
    end

    render :layout => "admin"
  end

  def show
    begin
      @event = Event.find_one(params[:id])
      render :layout => "admin"
    rescue => e
      logger.warn "#{e}" 
      redirect_to events_path
    end
  end

  def new
    @event = Event.new
    render :layout => "admin"
  end

  def edit
    begin
      @event = Event.find_one(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to edit_event_path
    end

    render :layout => "admin"
  end

  def update
    begin
      @event = Event.find_one(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to edit_event_path
    end
    
    hash = upload(params[:event][:cover], event_params, "cover")

    @event.update(hash)

    redirect_to edit_event_path(@event)
  end

  def create
    hash = upload(params[:event][:cover], event_params, "cover")

    @event = Event.create(hash)
    @event.save!

    redirect_to new_event_path
  end

  def destroy
    begin
      Event.delete_one(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to edit_event_path
    end
  end

  private
    def event_params
      params.require(:event).permit(:title, :likes, :description, :adresse, :sport_id, :cover => [:filename => [:@tempfile,:@original_filename,:@content_type,:@headers]])
    end

end
