class SportsController < ApplicationController

  def index
    @sports = Sport.index()
  end

  def show
    @sport = Sport.find_one(params[:id])
  end

  def new
    @sport = Sport.new
  end

  def edit
    @sport = Sport.find_one(params[:id])
  end

  def update
    @sport = Sport.find_one(params[:id])
    @sport.update(sport_params)

    redirect_to edit_sport_path(@sport)
  end
  
  def create
    uploaded_io = params[:sport][:icon]

    tmp_hash1 = sport_params
    tmp_hash2 = {"icon" => uploaded_io.original_filename}
    tmp_hash1.merge!(tmp_hash2)

    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    @sport = Sport.create(tmp_hash1)
    @sport.save!

    redirect_to new_sport_path
  end

  private
    def sport_params
      params.require(:sport).permit(:title, :icon => [:filename => [:@tempfile,:@original_filename,:@content_type,:@headers]])
    end

end
