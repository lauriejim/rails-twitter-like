class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params);
    user.save!

    redirect_to "/users/#{user.id}"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private
  def user_params
   params.require(:user).permit(:firstname, :lastname, :email)
  end
end
