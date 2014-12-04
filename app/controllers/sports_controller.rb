class SportsController < ApplicationController

  def index
    @sports = Sport.index()
  end

  def show
    @sport = Sport.findOne(params[:id])
  end

  def new
    @sport = Sport.new
  end

  def edit
    @sport = Sport.findOne(params[:id])
  end

  def update
    @sport = Sport.findOne(params[:id])
    @sport.update(sport_params)

    redirect_to edit_sport_path(@sport)
  end
  
  def create
    @sport = Sport.create(sport_params)
    @sport.save!

    redirect_to new_sport_path
  end

  private
    def sport_params
      params.require(:sport).permit(:title, :icon)
    end

end
