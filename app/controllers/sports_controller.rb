class SportsController < ApplicationController

  def index
    @sports = Sport.index()
  end

  def show
    @sports = Sport.findOne(params[:id])
  end

  def new
    @sport = Sport.new
  end
  
  def create
    Sport.create(title: params[:sport][:title], icon: params[:sport][:icon])
    redirect_to new_sport_path
  end

end
