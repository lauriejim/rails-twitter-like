require 'rails_helper'

RSpec.describe EventsController, :type => :controller do

  render_views

  describe "GET displayAll" do
    it "returns all events" do
      session[:user_rank] = "admin"
      sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png", background: "http://www.ffbb.png", color: "#FFFFFF")
      event = Event.create(title: "Tournoi de basket à Paris", cover:"http://www.ffbb.png", description:"Basket-ball event", adresse:"Paris, Basket", date: Date.today)
      event.sport = sport
      event.save!

      other_sport = Sport.create(title: "Football", icon: "http://www.fff.png", background: "http://www.ffbb.png", color: "#FFFFFF")
      other_event = Event.create(title: "Tournoi de football à Paris", cover:"http://www.fff.png", description:"Football event", adresse:"Paris, Foot", date: Date.today)
      other_event.sport = other_sport
      other_event.save!

      get :index
      expect(response).to have_http_status(:success)

      expect(response.body).to include("#{event.title}")
      expect(response.body).to include("#{sport.title}")
      expect(response.body).to include("#{other_event.title}")
      expect(response.body).to include("#{other_sport.title}")
    end
  end

  describe "GET displayBySport" do
    it "returns all events" do
      session[:user_rank] = "admin"
      sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png", background: "http://www.ffbb.png", color: "#FFFFFF")
      event = Event.create(title: "Tournoi de basket à Paris", cover:"http://www.ffbb.png", description:"Basket-ball event", adresse:"Paris, Basket", date: Date.today)
      event.sport = sport
      event.save!

      other_event = Event.create(title: "Tournoi de football à Montreuil", cover:"http://www.ffbbm.png", description:"Basket-ball event in Montreuil", adresse:"Montreuil, Basket", date: Date.today)
      other_event.sport = sport
      other_event.save!


      get "display_by_sport", id: sport.id

      expect(response).to have_http_status(:success)

      expect(response.body).to include("#{event.title}")
      expect(response.body).to include("#{sport.title}")
      expect(response.body).to include("#{other_event.title}")
      expect(response.body).to include("#{sport.title}")
    end
  end

  describe "GET displayBySport" do
    it "display one event" do
      session[:user_rank] = "admin"
      sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png", background: "http://www.ffbb.png", color: "#FFFFFF")
      sport.save!
      event = Event.create(title: "Tournoi de basket à Paris", cover:"http://www.ffbb.png", description:"Basket-ball event", adresse:"Paris, Basket", date: Date.today)
      event.sport = sport
      event.save!

      get "display_by_sport", id: event.id
      expect(response).to have_http_status(:success)

      expect(response.body).to include("#{event.title}")
      expect(response.body).to include("#{sport.title}")
    end
  end

end
