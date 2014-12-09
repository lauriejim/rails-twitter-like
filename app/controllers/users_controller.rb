class UsersController < ApplicationController
  def index
    @users = User.index
    render :layout => "admin"
  end

  def show
    @user = User.find_one(params[:id])
    render :layout => "admin"
  end

  def new
    @user = User.new
    @ranks = RailsTwitterLike::Application::RANKS
    render :layout => "admin"
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

  def edit
    @ranks = RailsTwitterLike::Application::RANKS
    @user = User.find_one(params[:id])
    render :layout => "admin"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render :layout => "admin", :action => 'edit'
    end
  end

  def destroy
  end

  private
  def user_params
   params.require(:user).permit(:firstname, :lastname, :email, :password, :rank)
  end
end
