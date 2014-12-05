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
    render :layout => "admin"
  end

  def create
    @sport = Sport.create(sport_params)
    @sport.save!

    redirect_to new_sport_path
    render :layout => "admin"
  end

  private
    def sport_params
      params.require(:sport).permit(:title, :icon)
    end

end
