require 'rails_helper'

RSpec.describe Event, :type => :model do
  it "create an event" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png", background: "http://www.ffbb.png", color: "#FFFFFF")
    event = Event.create(title: "Tournoi de basket à Paris", cover:"http://www.ffbb.png", description:"This is a short description", adresse:"Paris, Basket", date: Date.today)
    event.sport = sport
    event.save!

    found = Event.last
    expect(found.title).to eq("Tournoi de basket à Paris")
    expect(found.cover).to eq("http://www.ffbb.png")
    expect(found.description).to eq("This is a short description")
    expect(found.adresse).to eq("Paris, Basket")
  end

  it "event linked with a sport" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png", background: "http://www.ffbb.png", color: "#FFFFFF")
    event = Event.create(title: "Tournoi de basket à Paris", cover:"http://www.ffbb.png", description:"This is a short description", adresse:"Paris, Basket", date: Date.today)
    event.sport = sport
    expect(event.sport).to eq(sport)
    expect(event.sport_id).to eq(sport.id)

    expect(event.valid?).to eq(true)
    event.sport = nil
    expect(event.valid?).to eq(false)
  end

  it "get number of events" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png", background: "http://www.ffbb.png", color: "#FFFFFF")
    sport.save!
    event = Event.create(title: "Tournoi de basket à Paris", cover:"http://www.ffbb.png", description:"This is a short description", adresse:"Paris, Basket", date: Date.today)
    event.sport = sport
    event.save!
    other_event = Event.create(title: "Tournoi de basket à Montreuil", cover:"http://www.ffbb.png", description:"This is a short description", adresse:"Montreuil, Basket", date: Date.today)
    other_event.sport = sport
    other_event.save!

    expect(Event.count()).to eq(2)
  end

  it "display one event" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png", background: "http://www.ffbb.png", color: "#FFFFFF")
    sport.save!
    event = Event.create(title: "Tournoi de basket à Paris", cover:"http://www.ffbb.png", description:"This is a short description", adresse:"Paris, Basket", date: Date.today)
    event.sport = sport
    event.save!

    expect(Event.find_one(event.id)).to eq(event)
  end

  it "display all events in sport" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png", background: "http://www.ffbb.png", color: "#FFFFFF")
    sport.save!
    event = Event.create(title: "Tournoi de basket à Paris", cover:"http://www.ffbb.png", description:"This is a short description", adresse:"Paris, Basket", date: Date.today)
    event.sport = sport
    event.save!
    other_event = Event.create(title: "Tournoi de basket à Montreuil", cover:"http://www.ffbb.png", description:"This is a short description", adresse:"Montreuil, Basket", date: Date.today)
    other_event.sport = sport
    other_event.save!

    expect(Event.find_by_sport(sport.id)).to eq([event, other_event])
  end

  it "delete one event" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png", background: "http://www.ffbb.png", color: "#FFFFFF")
    sport.save!
    event = Event.create(title: "Tournoi de basket à Paris", cover:"http://www.ffbb.png", description:"This is a short description", adresse:"Paris, Basket", date: Date.today)
    event.sport = sport
    event.save!

    count = Event.count()
    Event.delete_one(event.id)

    expect(Event.count()).to eq(count-1)

  end
end