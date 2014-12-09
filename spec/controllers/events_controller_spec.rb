require 'rails_helper'

RSpec.describe EventsController, :type => :controller do

  render_views

  describe "GET displayAll" do
    it "returns all events" do
      sport = Sport.create(title: "Basket-ball", icon: "http://www.google.png")
      event = Event.create(title: "Basket-ball event", cover:"http://www.google.png", likes:"0", description:"This is a short description", adresse:"Tour Eiffel, Paris, 75000")
      event.sport = sport
      event.save!

      other_sport = Sport.create(title: "Basket-ball 2", icon: "http://www.google.png")
      other_event = Event.create(title: "Basket-ball event 2", cover:"http://www.yahoo.png", likes:"10", description:"This is a short", adresse:"Tour, Paris, 75000")
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
      sport = Sport.create(title: "Basket-ball", icon: "http://www.google.png")
      event = Event.create(title: "Basket-ball event", cover:"http://www.google.png", likes:"0", description:"This is a short description", adresse:"Tour Eiffel, Paris, 75000")
      event.sport = sport
      event.save!

      other_event = Event.create(title: "Basket-ball event 2", cover:"http://www.google.png", likes:"0", description:"This is a short description", adresse:"Tour Eiffel, Paris, 75000")
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
      sport = Sport.create(title: "Basket-ball", icon: "http://www.google.png")
      sport.save!
      event = Event.create(title: "Basket-ball event", cover:"http://www.google.png", likes:"0", description:"This is a short description", adresse:"Tour Eiffel, Paris, 75000")
      event.sport = sport
      event.save!

      get "display_by_sport", id: event.id
      expect(response).to have_http_status(:success)

      expect(response.body).to include("#{event.title}")
      expect(response.body).to include("#{sport.title}")
    end
  end

end
