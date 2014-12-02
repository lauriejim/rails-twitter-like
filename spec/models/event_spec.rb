require 'rails_helper'

RSpec.describe Event, :type => :model do
  it "will do something" do
    event = Event.create(title: "Basket-ball event", cover:"http://www.google.png", likes:"0", description:"This is a short description", adresse:"Tour Eiffel, Paris, 75000")
    event.save!

    found = Event.last
    expect(found.title).to eq("Basket-ball event")
    expect(found.cover).to eq("http://www.google.png")
    expect(found.likes).to eq(0)
    expect(found.description).to eq("This is a short description")
    expect(found.adresse).to eq("Tour Eiffel, Paris, 75000")
  end
end