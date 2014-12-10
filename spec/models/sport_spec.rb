require 'rails_helper'

RSpec.describe Sport, :type => :model do
  it "can be create a sport" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png")
    sport.save!

    found = Sport.last
    expect(found.title).to eq("Basket-ball")
    expect(found.icon).to eq("http://www.ffbb.png")
  end

  it "get number of sport" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png")
    sport.save!
    other_sport = Sport.create(title: "Football", icon: "http://www.fff.png")
    other_sport.save!

    expect(Sport.count()).to eq(2)
  end

  it "requires a title and an icon" do
    sport = Sport.new
    expect(sport.valid?).to eq(false)

    sport.title = "Rigby"
    expect(sport.valid?).to eq(false)

    sport.icon = "http://www.ffbb.png"
    expect(sport.valid?).to eq(true)
  end

  it "display all sports" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png")
    sport.save!
    other_sport = Sport.create(title: "Football", icon: "http://www.fff.png")
    other_sport.save!

    expect(Sport.index).to eq([sport, other_sport])
  end

  it "delete one sport" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.ffbb.png")
    sport.save!

    count = Sport.count()
    Sport.delete_one(sport.id)

    expect(Sport.count()).to eq(count-1)

  end
end
