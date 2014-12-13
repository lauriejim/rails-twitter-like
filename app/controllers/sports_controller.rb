class SportsController < ApplicationController
  before_action :require_login_admin, only: [:index, :show, :new, :edit, :update, :create, :destroy]
  layout "admin"

  def index
    @sports = Sport.index
  end

  def app_list
    @sports = Sport.index
    @follows = User.find(session[:user_id]).follows
    render layout: 'application'
  end

  def show
    begin
      @sport = Sport.find_one(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to sport_path
    end
  end

  def new
    @sport = Sport.new
  end

  def edit
    begin
      @sport = Sport.find_one(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to sport_path
    end
  end

  def update
    begin
      @sport = Sport.find_one(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to sport_path
    end

    if params[:sport].key?('icon') && params[:sport].key?('background')
      hash = upload(params[:sport][:icon], sport_params, "icon")
      hash = upload(params[:sport][:background], hash, "background")
      @sport.update(hash)
    elsif params[:sport].key?('icon')
      hash = upload(params[:sport][:icon], sport_params, "icon")
      @sport.update(hash)
    elsif params[:sport].key?('background')
      hash = upload(params[:sport][:background], sport_params, "background")
      @sport.update(hash)
    else
      @sport.update(sport_params)
    end

    redirect_to edit_sport_path(@sport)
  end

  def create
    hash = upload(params[:sport][:icon], sport_params, "icon")
    hash = upload(params[:sport][:background], hash, "background")

    @sport = Sport.create(hash)
    @sport.save!

    redirect_to new_sport_path
  end

  def destroy
    begin
      Sport.delete_one(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to edit_event_path
    end
  end

  private
    def sport_params
      params.require(:sport).permit(:title, :color, :icon => [:filename => [:@tempfile,:@original_filename,:@content_type,:@headers]], :background => [:filename => [:@tempfile,:@original_filename,:@content_type,:@headers]])
    end

end
