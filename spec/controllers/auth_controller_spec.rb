require 'rails_helper'

RSpec.describe AuthController, :type => :controller do

  render_views

  describe "Authentification" do
    it "match one user" do
      user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")

      post :create, user: {email: user.email, password: user.password}

      expect(session[:user].email).to eq(user.email)
    end
  end

end
