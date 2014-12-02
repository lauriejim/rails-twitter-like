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
   params.require(:post).permit(:firstname, :lastname, :email, :rank)
  end
end
