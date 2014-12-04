require 'rails_helper'

RSpec.describe Event, :type => :model do
  it "create an event" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.google.png")
    event = Event.create(title: "Basket-ball event", cover:"http://www.google.png", likes:"0", description:"This is a short description", adresse:"Tour Eiffel, Paris, 75000")
    event.sport = sport
    event.save!

    found = Event.last
    expect(found.title).to eq("Basket-ball event")
    expect(found.cover).to eq("http://www.google.png")
    expect(found.likes).to eq(0)
    expect(found.description).to eq("This is a short description")
    expect(found.adresse).to eq("Tour Eiffel, Paris, 75000")
  end

  it "event linked with a sport" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.google.png")
    event = Event.new(sport: sport)
    expect(event.sport).to eq(sport)
    expect(event.sport_id).to eq(sport.id)

    expect(event.valid?).to eq(true)
    event.sport = nil
    expect(event.valid?).to eq(false)
  end

  it "display one event" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.google.png")
    sport.save!
    event = Event.new(sport: sport)
    event.save!

    expect(Event.findOne(event.id)).to eq(event)
  end

  it "display all events in sport" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.google.png")
    sport.save!
    event = Event.new(sport: sport)
    event.save!
    other_event = Event.new(sport: sport)
    other_event.save!

    expect(Event.findBySport(sport.id)).to eq([event, other_event])
  end
end