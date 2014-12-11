class EventsController < ApplicationController
  before_action :require_login_admin, only: [:index, :display_by_sport, :show, :new, :edit, :update, :create, :destroy]
  layout "admin"

  def home
    @events = Event.find_all
    render '/home', layout: 'application'
  end

  def index
    @events = Event.all
  end

  def display_by_sport
    begin
      @events = Event.find_by_sport(params[:id])
      @sport = Sport.find_one(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to events_path
    end
  end

  def app_show
     begin
      @event = Event.find_one(params[:id])
      render 'events/app_show', layout: 'application'
    rescue => e
      logger.warn "#{e}" 
      render :status => 404
    end
  end

  def show
    begin
      @event = Event.find_one(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to events_path
    end
  end

  def new
    @event = Event.new
  end

  def edit
    begin
      @event = Event.find_one(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to edit_event_path
    end
  end

  def update
    begin
      @event = Event.find_one(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to edit_event_path
    end

    if params[:event].key?('cover')
      hash = upload(params[:event][:cover], event_params, "cover")
      @event.update(hash)
    else
      @event.update(event_params)
    end

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
