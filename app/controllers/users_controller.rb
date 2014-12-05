class UsersController < ApplicationController
  # def index
  #   @users = User.all
  # end

  # def show
  #   @user = User.find(params[:id])
  # end

  def new
    @user = User.new
    @ranks = RailsTwitterLike::Application::RANKS
  end

  def create
    @user = User.new(user_params);
    if @user.save
      redirect_to users_path
    else
      @ranks = RailsTwitterLike::Application::RANKS
      render :new
    end
  end

  # def edit
  #   @ranks = RailsTwitterLike::Application::RANKS
  #   @user = User.find(params[:id])
  # end

  # def update
  #   user = User.find(params[:id])
  #   if params[:user][:rank]
  #     user.update(user_params.merge({rank: params[:user][:rank]}))
  #   else
  #     user.update(user_params)
  #   end

  #   redirect_to "/users/#{user.id}"
  # end

  # def destroy
  # end

  private
  def user_params
   params.require(:user).permit(:firstname, :lastname, :email, :password, :rank)
  end
end
