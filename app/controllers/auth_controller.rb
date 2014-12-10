class AuthController < ApplicationController
  def login
    # render login form
  end

  def register
    @user = User.new
  end

  # set user in session
  def create
    user = User.auth(auth_params)
    if user
      session[:user_id] = user.id
      session[:user_rank] = user.rank
      session[:user_firstname] = user.firstname
      session[:user_lastname] = user.lastname
      redirect_to users_path
    else
      render :login
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_rank] = nil
    session[:user_firstname] = nil
    session[:user_lastname] = nil
    redirect_to users_path
  end

  private
  def auth_params
    params.permit(:email, :password)
  end
end
