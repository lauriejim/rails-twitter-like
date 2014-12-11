class ActionsController < ApplicationController
  def follow
    @user = User.find(session[:user_id])
    @sport = Sport.find(params[:id])

    Follow.create(user: @user, sport: @sport)
  end

  def unfollow
    @user = User.find(session[:user_id])
    @sport = Sport.find(params[:id])

    Follow.where(user: @user, sport: @sport)[0].destroy
  end

  def like
    @user = User.find(session[:user_id])
    @event = Event.find(params[:id])

    Follow.create(user: @user, event: @sport)
  end

  def unlike
    @user = User.find(session[:user_id])
    @event = Event.find(params[:id])

    Follow.where(user: @user, event: @sport)[0].destroy
  end
end
