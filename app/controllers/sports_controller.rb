class SportsController < ApplicationController

  def self.display
    Sport.all.find()
  end
end
