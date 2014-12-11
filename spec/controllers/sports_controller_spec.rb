require 'rails_helper'

RSpec.describe SportsController, :type => :controller do

  render_views

  describe "GET index" do
    it "returns all sports" do
      session[:user_rank] = "admin"
      sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png", background: "http://www.ffbb.png", color: "#FFFFFF")
      sport.save!

      other_sport = Sport.create(title: "Football", icon: "http://www.fff.png", background: "http://www.ffbb.png", color: "#FFFFFF")
      other_sport.save!

      get :index
      expect(response).to have_http_status(:success)

      expect(response.body).to include("#{sport.title}")
      expect(response.body).to include("/uploads/#{sport.icon}")
      expect(response.body).to include("#{other_sport.title}")
      expect(response.body).to include("/uploads/#{other_sport.icon}")
    end
  end

  describe "GET show" do
    it "returns one sport" do
      session[:user_rank] = "admin"
      sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png", background: "http://www.ffbb.png", color: "#FFFFFF")
      sport.save!

      get :show, id: sport.id
      expect(response).to have_http_status(:success)

      expect(response.body).to include("#{sport.title}")
      expect(response.body).to include("/uploads/#{sport.icon}")
    end
  end

end
