class SportsController < ApplicationController

  def displayAll
    @sports = Sport.all
  end
  
end
