require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  render_views

  describe "GET index" do
    it "display user list" do
      user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", rank: "user")
      user_1 = User.create(firstname: "Jean1", lastname: "Bon", email: "jean1@bon.by", rank: "user")
      user_2 = User.create(firstname: "Jean2", lastname: "Bon", email: "jean2@bon.by", rank: "user")

      get :index
      expect(response).to have_http_status(:success)

      expect(response.body).to include("#{user.firstname}")
      expect(response.body).to include("#{user_1.firstname}")
      expect(response.body).to include("#{user_2.firstname}")
    end
  end

  describe "GET show" do
    it "display user" do
      user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", rank: "user")

      get :show, id: user.id
      expect(response).to have_http_status(:success)

      expect(response.body).to include("Jean")
      expect(response.body).to include("Bon")
      expect(response.body).to include("jean@bon.by")
    end
  end

  describe "POST create" do
    it "create new user" do

      post :create, post: {firstname: "Jean", lastname: "Bon", email: "jean@bon.by", rank: "user"}
      expect(response).to have_http_status(:success)

      user = User.last
      expect(user.firstname).to eq("Jean")
      expect(user.lastname).to eq("Bon")
      expect(user.email).to eq("jean@bon.by")
      expect(user.rank).to eq("user")
    end
  end

  # describe "GET update" do
  #   it "returns http success" do
  #     put :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET destroy" do
  #   it "returns http success" do
  #     delete :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
