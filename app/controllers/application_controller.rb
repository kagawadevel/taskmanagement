class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    redirect_to new_session_path, notice: 'ログインしてください' unless logged_in?
  end

  class Forbidden < ActionController::ActionControllerError
  end

  rescue_from Forbidden, with: :rescue403

  private

  def rescue403(e)
    @exception = e
    render template: 'errors/forbidden', status: 403
  end

end
