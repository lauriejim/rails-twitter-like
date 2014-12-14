class EventsController < ApplicationController
  before_action :require_login_admin, only: [:index, :display_by_sport, :show, :new, :edit, :update, :create, :destroy]
  layout "admin"

  def home
    @sports = Sport.all
    if session[:user_id]
      if session[:user_follows]['pop']
        @events = Event.joins(:likes).group("likes.event_id").order("count(likes.event_id) desc")
      else
        @events = Event.where(sport: Sport.where(title: session[:user_follows].keys))
      end
    else
      @events = Event.find_all
    end
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
    @event = Event.find_one(params[:id])
    if session[:user_id]
      @have_like = User.find(session[:user_id]).likes.where(user_id: session[:user_id], event_id: @event.id).count
    end
    render 'events/app_show', layout: 'application'
  end

  def show
    @event = Event.find_one(params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find_one(params[:id])
  end

  def update
    @event = Event.find_one(params[:id])

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
    Event.delete_one(params[:id])
  end

  private
    def event_params
      params.require(:event).permit(:title, :likes, :description, :adresse, :sport_id, :date, :cover => [:filename => [:@tempfile,:@original_filename,:@content_type,:@headers]])
    end

end
