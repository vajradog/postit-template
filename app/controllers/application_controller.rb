class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?
  # to make them available also in view templates.

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    # if session because it will throw an exception if it cannot find a user
    # the @current instance variable is for memoization because this method
    # continued... will be called many times.
  end

  def logged_in?
    !!current_user
    # two bangs turns any object into a boolean value. ! false and !! is true
  end

  def require_user
    unless logged_in?
      flash[:error] = 'Please log in to do that'
      redirect_to login_path
    end
  end

  def require_admin
    access_denied unless logged_in? and current_user.admin?
  end

  def access_denied
    flash[:error] = "Not authorised to do that"
    redirect_to root_path
  end
end
