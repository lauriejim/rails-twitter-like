require 'rails_helper'

RSpec.describe User, :type => :model do
  it "create a user with full infos" do
    user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")

    found = User.last
    expect(found.firstname).to eq(user.firstname)
    expect(found.lastname).to eq(user.lastname)
    expect(found.email).to eq(user.email)
    expect(found.password).to_not eq("pcw123")
    expect(found.rank).to eq(user.rank)
  end

  it "require firstname lastname email password and rank" do
    user = User.new
    expect(user.valid?).to eq(false)

    user.firstname = "Jean"
    expect(user.valid?).to eq(false)

    user.lastname = "Bon"
    expect(user.valid?).to eq(false)

    user.email = "jean@bon.by"
    expect(user.valid?).to eq(false)

    user.password = "pcw123"
    expect(user.valid?).to eq(true)
  end

  it "requires a valid email" do
    user = User.create(firstname: "Jean", lastname: "Bon", password: "pcw123", rank: "user")
    expect(user.valid?).to eq(false)

    user.email = "jean"
    expect(user.valid?).to eq(false)

    user.email = "jean@bon"
    expect(user.valid?).to eq(false)

    user.email = "jean@bon.by"
    expect(user.valid?).to eq(true)
  end

  it "user email is unique" do
    user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")
    expect(user.valid?).to eq(true)

    other_user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")
    expect(other_user.valid?).to eq(false)
  end

  it "password is hashed" do
    user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")

    found = User.last
    expect(found.password).to_not eq("pcw123")
  end

  it "delete one user" do
    user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")

    expect(User.count()).to eq(1)
    
    User.delete_one(user.id)

    expect(User.count()).to eq(0)
  end
end