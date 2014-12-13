class ActionsController < ApplicationController
  before_action :require_login_admin, only: [:uncomment]

  def follow
    @user = User.find(session[:user_id])
    @sport = Sport.find(params[:id])
    session[:user_follows][@sport.title] = true
    Follow.create(user: @user, sport: @sport)
  end

  def unfollow
    @user = User.find(session[:user_id])
    @sport = Sport.find(params[:id])
    session[:user_follows].delete(@sport.title)
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

  def uncomment
    comment = Comment.find(params[:id])
    event_id = comment.event_id
    comment.destroy
    redirect_to Event.find(event_id)
  end

  def filter
    if params[:id] == 'pop'
      if session[:user_follows][params[:id]]
        session[:user_follows] = session[:filter_back]
      else
        session[:filter_back] = session[:user_follows]
        session[:user_follows] = {}
        session[:user_follows][params[:id]] = true
      end
    else
      session[:user_follows].delete('pop') if session[:user_follows]['pop']
      @sport = Sport.find(params[:id])
      if session[:user_follows][@sport.title]
        session[:user_follows].delete(@sport.title)
      else
        session[:user_follows][@sport.title] = true
      end
    end
    redirect_to '/'
  end
end
