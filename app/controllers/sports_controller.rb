class SportsController < ApplicationController

  def index
    @sports = Sport.index()
    render :layout => "admin"
  end

  def show
    begin
      @sport = Sport.find_one(params[:id])
      render :layout => "admin"
    rescue => e
      logger.warn "#{e}" 
      redirect_to sport_path
    end
  end

  def new
    @sport = Sport.new
    render :layout => "admin"
  end

  def edit
    begin
      @sport = Sport.find_one(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to sport_path
    end

    render :layout => "admin"
  end

  def update
    begin
      @sport = Sport.find_one(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to sport_path
    end

    hash = upload(params[:sport][:icon], sport_params, "icon")
    
    @sport.update(hash)

    redirect_to edit_sport_path(@sport)
  end

  def create
    hash = upload(params[:sport][:icon], sport_params, "icon")

    @sport = Sport.create(hash)
    @sport.save!

    redirect_to new_sport_path
  end

  def destroy
    begin
      Sport.destroy(params[:id])
    rescue => e
      logger.warn "#{e}" 
      redirect_to edit_event_path
    end
  end

  private
    def sport_params
      params.require(:sport).permit(:title, :icon => [:filename => [:@tempfile,:@original_filename,:@content_type,:@headers]])
    end

end
