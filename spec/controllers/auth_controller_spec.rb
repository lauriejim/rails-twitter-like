require 'rails_helper'

RSpec.describe AuthController, :type => :controller do

  render_views

  describe "Authentification" do
    it "match one user" do
      user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")

      post :create, email: user.email, password: 'pcw123'
      expect(response).to redirect_to(users_path)

      expect(session[:user_firstname]).to eq(user.firstname)
      expect(session[:user_lastname]).to eq(user.lastname)
      expect(session[:user_rank]).to eq(user.rank)
      expect(session[:user_id]).to eq(user.id)
    end

    it "redirect on login on fail" do
      user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")

      post :create, email: user.email, password: "bad"
      expect(response).to have_http_status(:success)

      expect(session[:user]).to eq(nil)
    end

    it "logout" do
      user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")
      session[:user_id] = user.id
      session[:user_rank] = user.rank
      session[:user_firstname] = user.firstname
      session[:user_lastname] = user.lastname

      get :destroy

      expect(session[:user_firstname]).to eq(nil)
      expect(session[:user_lastname]).to eq(nil)
      expect(session[:user_rank]).to eq(nil)
      expect(session[:user_id]).to eq(nil)
    end
  end

end
