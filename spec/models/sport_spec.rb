require 'rails_helper'

RSpec.describe Sport, :type => :model do
  it "can be create a sport" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.google.png")
    sport.save!

    found = Sport.last
    expect(found.title).to eq("Basket-ball")
    expect(found.icon).to eq("http://www.google.png")
  end

  it "requires a title and an icon" do
    sport = Sport.new
    expect(sport.valid?).to eq(false)

    sport.title = "Rigby"
    expect(sport.valid?).to eq(false)

    sport.icon = "http://www.google.png"
    expect(sport.valid?).to eq(true)
  end

  it "display all sports" do
    sport = Sport.create(title: "Basket-ball", icon: "http://www.google.png")
    sport.save!
    other_sport = Sport.create(title: "Football", icon: "http://www.google.png")
    other_sport.save!

    expect(Sport.display).to eq([sport, other_sport])
  end
end
