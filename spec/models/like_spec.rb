require 'rails_helper'

RSpec.describe Like, :type => :model do
  it "user like event" do
    user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")
    sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png")

    event = Event.create(title: "Tournoi de basket à Paris", cover:"http://www.ffbb.png", description:"Basket-ball event", adresse:"Paris, Basket")
    event.sport = sport
    event.save!

    event_2 = Event.create(title: "Tournoi de basket à Lyon", cover:"http://www.ffbb.png", description:"Basket-ball event2", adresse:"Lyon, Basket")
    event_2.sport = sport
    event_2.save!

    Like.create(user: user, event: event)
    Like.create(user: user, event: event_2)

    user = User.last

    expect(user.likes[0].event.title).to eq("Tournoi de basket à Paris")
    expect(user.likes[1].event.title).to eq("Tournoi de basket à Lyon")
  end
end
