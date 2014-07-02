class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?
  #helper_method because these methods are also used in view templates, otherwise they will only be available in controllers.


  def current_user
   @current_user ||= User.find(session[:user_id]) if session[:user_id]
   # if session because it will throw an exception if it cannot find a user
   # the @current instance variable is for memoization because this method will be called many times.
  end

  def logged_in?
    !!current_user
    # two bangs turns any object into a boolean value. ! false and !! is true
  end

  def require_user
    if !logged_in?
      flash[:error]="Please log in to do that"
      redirect_to login_path
    end
  end
end
