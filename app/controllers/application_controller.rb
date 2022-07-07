class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # transformed User obj in bool with "!!"
    !!current_user
  end

  def required_user
    unless logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
