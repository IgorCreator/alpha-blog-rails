class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :flash_style

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

  def flash_style(level)
    case level
    when "notice" then "info"
    when "success" then "success"
    when "error" then "danger"
    when "alert" then "warning"
    end
  end
end
