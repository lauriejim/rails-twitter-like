require 'rails_helper'

RSpec.describe SportsController, :type => :controller do

  render_views

  describe "GET displayAll" do
    it "returns all sports" do
      sport = Sport.create(title: "Basket-ball", icon: "http://www.google.png")
      sport.save!

      other_sport = Sport.create(title: "Basket-ball 2", icon: "http://www.google.png")
      other_sport.save!

      get :displayAll
      expect(response).to have_http_status(:success)

      expect(response.body).to include("#{sport.title} & icon #{sport.icon}")
      expect(response.body).to include("#{other_sport.title} & icon #{other_sport.icon}")
    end
  end

end
