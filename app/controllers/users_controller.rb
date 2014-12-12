class UsersController < ApplicationController
  before_action :require_login_admin, only: [:index]
  layout "admin"

  def index
    @users = User.index
  end

  def show
    @user = User.find_one(params[:id])
  end

  def user_json
    @user = User.find_one(params[:id])
    render json: @user.to_json
  end

  def new
    @user = User.new
    @ranks = RailsTwitterLike::Application::RANKS
  end

  def create
    @user = User.new(user_params);
    if @user.save
      if request.fullpath == '/users/create'
        redirect_to auth_login_path
      else
        redirect_to users_path
      end
    else
      @ranks = RailsTwitterLike::Application::RANKS
      if request.fullpath == '/users/create'
        render '/auth/register', :layout => 'application'
      else
        render :new
      end
    end
  end

  def edit
    @ranks = RailsTwitterLike::Application::RANKS
    @user = User.find_one(params[:id])
  end

  def update
    @user = User.find_one(params[:id])

    if params[:user].key?('picture')
      hash = upload(params[:user][:picture], user_params, "picture")
      @user.update(hash)
      redirect_to @user
    elsif @user.update_attributes(user_params)
      redirect_to @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    User.delete_one(params[:id])
    redirect_to users_path
  end

  private
  def user_params
    if request.fullpath == '/users/create'
      return params.permit(:firstname, :lastname, :email, :password)
    end
    if !session[:user_rank] || session[:user_rank] == 'user'
      params.require(:user).permit(:firstname, :lastname, :email, :password, :picture => [:filename => [:@tempfile,:@original_filename,:@content_type,:@headers]])
    else
      params.require(:user).permit(:firstname, :lastname, :email, :password, :rank, :picture => [:filename => [:@tempfile,:@original_filename,:@content_type,:@headers]])
    end
  end
end
