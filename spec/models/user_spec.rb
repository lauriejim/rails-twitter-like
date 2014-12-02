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
end