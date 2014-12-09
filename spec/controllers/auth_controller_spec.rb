require 'rails_helper'

RSpec.describe AuthController, :type => :controller do

  render_views

  describe "Authentification" do
    it "match one user" do
      user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")

      post :create, user: {email: user.email, password: 'pcw123'}
      expect(response).to redirect_to(users_path)

      expect(session[:user].email).to eq(user.email)
    end

    it "redirect on login on fail" do
      user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")

      post :create, user: {email: user.email, password: "bad"}
      expect(response).to have_http_status(:success)

      expect(session[:user]).to eq(nil)
    end
  end

end
