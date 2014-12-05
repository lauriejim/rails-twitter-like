class SportsController < ApplicationController

  def index
    @sports = Sport.index()
    render :layout => "admin"
  end

  def show
    @sport = Sport.find_one(params[:id])
    render :layout => "admin"
  end

  def new
    @sport = Sport.new
    render :layout => "admin"
  end

  def edit
    @sport = Sport.find_one(params[:id])
    render :layout => "admin"
  end

  def update
    @sport = Sport.find_one(params[:id])
    @sport.update(sport_params)

    redirect_to edit_sport_path(@sport)
  end

  def create
    hash = upload(params[:sport][:icon], sport_params, "icon")

    @sport = Sport.create(hash)
    @sport.save!

    redirect_to new_sport_path
  end

  private
    def sport_params
      params.require(:sport).permit(:title, :icon => [:filename => [:@tempfile,:@original_filename,:@content_type,:@headers]])
    end

end
