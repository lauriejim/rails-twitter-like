require 'rails_helper'

RSpec.describe Follow, :type => :model do
  it "user folow sport" do
    user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")
    sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png")
    sport_2 = Sport.create(title: "Foot-ball", icon: "http://www.ffbb.png")

    Follow.create(user: user, sport: sport)
    Follow.create(user: user, sport: sport_2)

    user = User.last

    expect(user.follows[0].sport.title).to eq("Basket-ball")
    expect(user.follows[1].sport.title).to eq("Foot-ball")
  end

  it "user unfolow sport" do
    user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")
    sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png")
    sport_2 = Sport.create(title: "Foot-ball", icon: "http://www.ffbb.png")

    Follow.create(user: user, sport: sport)
    Follow.create(user: user, sport: sport_2)

    user = User.last

    expect(user.follows[0].sport.title).to eq("Basket-ball")
    expect(user.follows[1].sport.title).to eq("Foot-ball")
    expect(user.follows.count).to eq(2)

    Follow.where(user: user, sport: sport)[0].destroy
    expect(user.follows.count).to eq(1)


  end
end
