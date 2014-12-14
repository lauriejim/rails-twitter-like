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
    @sport = Sport.find_one(params[:id])
  end

  def new
    @sport = Sport.new
  end

  def edit
    @sport = Sport.find_one(params[:id])
  end

  def update
    @sport = Sport.find_one(params[:id])

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
    if params[:sport].key?('icon')
      hash = upload(params[:sport][:icon], sport_params, "icon")
    end
    if params[:sport].key?('background')
      hash = upload(params[:sport][:background], hash, "background")
    end

    @sport = Sport.new(hash)
    if @sport.save
      redirect_to new_sport_path
    else
      render :new
    end

  end

  def destroy
    Sport.delete_one(params[:id])
  end

  private
    def sport_params
      params.require(:sport).permit(:title, :color, :icon => [:filename => [:@tempfile,:@original_filename,:@content_type,:@headers]], :background => [:filename => [:@tempfile,:@original_filename,:@content_type,:@headers]])
    end
end
