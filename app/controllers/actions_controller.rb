class ActionsController < ApplicationController
  def follow
    @user = User.find(session[:user_id])
    @sport = Sport.find(params[:id])
    session[:user_follows][@sport.title] = true
    Follow.create(user: @user, sport: @sport)
  end

  def unfollow
    @user = User.find(session[:user_id])
    @sport = Sport.find(params[:id])
    session[:user_follows][@sport.title] = false
    Follow.where(user: @user, sport: @sport)[0].destroy
  end

  def like
    @user = User.find(session[:user_id])
    @event = Event.find(params[:id])

    Like.create(user: @user, event: @event)
    render :status => 200
  end

  def unlike
    @user = User.find(session[:user_id])
    @event = Event.find(params[:id])

    Like.where(user: @user, event: @event)[0].destroy
  end

  def comment
    @user = User.find(session[:user_id])
    @event = Event.find(params[:id])
    @have_like = @user.likes.where(user_id: session[:user_id], event_id: @event.id).count
    message = params[:message]

    Comment.create(user: @user, event: @event, message: message)
    render 'events/app_show', layout: 'application'
  end

  def filter

  end
end
