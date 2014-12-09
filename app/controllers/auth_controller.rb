class AuthController < ApplicationController
  def login
    # render login form
  end

  def register
    # render creation user form
  end

  # set user in session
  def create
    user = User.auth(auth_params)
    if user
      session[:user] = user
      redirect_to users_path
    end
  end

  private
  def auth_params
    params.require(:user).permit(:email, :password)
  end
end
