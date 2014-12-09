require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  render_views

  describe "User creation" do
    it "display creation form" do
      get :new
      expect(response).to have_http_status(:success)

      expect(response.body).to include("firstname")
      expect(response.body).to include("lastname")
      expect(response.body).to include("email")
      expect(response.body).to include("password")
      expect(response.body).to include("rank")

      ranks = RailsTwitterLike::Application::RANKS
      ranks.each do |r|
        expect(response.body).to include(r)
      end

      expect(response.body).to include("Create User")
    end

    it "create user" do
      post :create, user: {firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user"}
      expect(response).to redirect_to(users_path)

      user = User.last
      expect(user.firstname).to eq("Jean")
      expect(user.lastname).to eq("Bon")
      expect(user.email).to eq("jean@bon.by")
      expect(user.password).to_not eq("pcw123")
      expect(user.password).to_not eq("")
      expect(user.rank).to eq("user")
    end

    it "handle errors" do
      post :create, user: {firstname: "Jean"}
      count = User.last
      expect(count).to eq(nil)
      expect(response.body).to include("Jean")

      post :create, user: {firstname: "Jean", lastname: "Bon"}
      count = User.last
      expect(count).to eq(nil)
      expect(response.body).to include("Jean")
      expect(response.body).to include("Bon")

      post :create, user: {firstname: "Jean", lastname: "Bon", email: "jean@bon.by"}
      count = User.last
      expect(count).to eq(nil)
      expect(response.body).to include("Jean")
      expect(response.body).to include("Bon")
      expect(response.body).to include("jean@bon.by")

      post :create, user: {firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user"}
      expect(response).to redirect_to(users_path)
    end
  end

  describe "User edit" do
    it "set user infos in form" do
      user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")

      get :edit, id: user.id
      expect(response).to have_http_status(:success)

      expect(response.body).to include(user.firstname)
      expect(response.body).to include(user.lastname)
      expect(response.body).to include(user.email)
      expect(response.body).to include(user.rank)
      expect(response.body).to include("admin")
      expect(response.body).to_not include(user.password)
    end

    it "update user" do
      user = User.create(firstname: "Jean", lastname: "Bon", email: "jean@bon.by", password: "pcw123", rank: "user")
      user_update_informations = {firstname: "Jean1", lastname: "Bon1", email: "jean1@bon.by", password: "pcw1234", rank: "admin"}

      post :update, id: user.id, user: user_update_informations
      expect(response).to redirect_to(user)

      found = User.last
      expect(found.firstname).to eq(user_update_informations[:firstname])
      expect(found.lastname).to eq(user_update_informations[:lastname])
      expect(found.email).to eq(user_update_informations[:email])
      expect(found.rank).to eq(user_update_informations[:rank])
    end
  end

  # describe "GET destroy" do
  #   it "returns http success" do
  #     delete :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
