class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :upload, :currentPath

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def upload(uploaded_io, strong_parameters, entry)

    tmp_hash1 = strong_parameters
    tmp_hash2 = {entry => uploaded_io.original_filename}
    tmp_hash1.merge!(tmp_hash2)

    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    tmp_hash1
  end

  def currentPath(path)
    'active' if request.fullpath.eql?(path)
  end

  def render_404
    respond_to do |format|
      format.html { render '/not_found', layout: 'application' }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  private
  def require_login_admin
    unless session[:user_rank] == "admin"
      redirect_to auth_login_path
    end
  end
end
