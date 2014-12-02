require 'rails_helper'

RSpec.describe User, :type => :model do
  it "create a user" do
    user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", rank: "user")
    user.save!

    found = User.last
    expect(found.firstname).to eq("Jean")
    expect(found.lastname).to eq("Bon")
    expect(found.email).to eq("jean@bon.by")
    expect(found.rank).to eq("user")
  end

  it "require firstname lastname and email" do
    user = User.new
    expect(user.valid?).to eq(false)

    user.firstname = "Jean"
    expect(user.valid?).to eq(false)

    user.lastname = "Bon"
    expect(user.valid?).to eq(false)

    user.email = "jean@bon.by"
    expect(user.valid?).to eq(false)

    user.rank = "user"
    expect(user.valid?).to eq(true)
  end

  it "requires a valid email" do
    user = User.new(firstname: "Jean", lastname: "Bon", rank: "user")
    expect(user.valid?).to eq(false)

    user.email = "jean"
    expect(user.valid?).to eq(false)

    user.email = "jean@bon"
    expect(user.valid?).to eq(false)

    user.email = "jean@bon.by"
    expect(user.valid?).to eq(true)
  end

  it "user email is unique" do
    user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", rank: "user")
    expect(user.valid?).to eq(true)

    other_user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", rank: "user")
    expect(other_user.valid?).to eq(false)
  end
end