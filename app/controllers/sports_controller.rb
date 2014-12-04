class SportsController < ApplicationController

  def displayAll
    @sports = Sport.all
  end
  
  def create
    Sport.create(title: params[:post][:title], icon: params[:post][:icon])
    redirect_to posts_path
  end

end
