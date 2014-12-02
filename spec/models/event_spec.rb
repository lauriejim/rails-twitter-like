require 'rails_helper'

RSpec.describe Event, :type => :model do
  it "create an event" do
    category = Category.create(title: "Basket-ball", icon: "http://www.google.png")
    event = Event.create(title: "Basket-ball event", cover:"http://www.google.png", likes:"0", description:"This is a short description", adresse:"Tour Eiffel, Paris, 75000")
    event.category = category
    event.save!

    found = Event.last
    expect(found.title).to eq("Basket-ball event")
    expect(found.cover).to eq("http://www.google.png")
    expect(found.likes).to eq(0)
    expect(found.description).to eq("This is a short description")
    expect(found.adresse).to eq("Tour Eiffel, Paris, 75000")
  end

  it "event linked with a category" do
    category = Category.create(title: "Basket-ball", icon: "http://www.google.png")
    event = Event.new(category: category)
    expect(event.category).to eq(category)
    expect(event.category_id).to eq(category.id)

    expect(event.valid?).to eq(true)
    event.category = nil
    expect(event.valid?).to eq(false)
  end
end