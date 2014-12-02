require 'rails_helper'

RSpec.describe Category, :type => :model do
  it "can be create a category" do
    category = Category.create(title: "Basket-ball", icon: "http://www.google.png")
    category.save!

    found = Category.last
    expect(found.title).to eq("Basket-ball")
    expect(found.icon).to eq("http://www.google.png")
  end

  it "requires a title and an icon" do
    category = Category.new
    expect(category.valid?).to eq(false)

    category.title = "Rigby"
    expect(category.valid?).to eq(false)

    category.icon = "http://www.google.png"
    expect(category.valid?).to eq(true)
  end
end