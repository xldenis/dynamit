class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def current_user
    @current_user ||= User.find(session[:current_user_id])
  end
  def logged_in?

    current_user != nil
  end
  def authorized?
    if params[:user_id] != nil
      unless params[:user_id] == current_user.id.to_s
        redirect_to :root 
      end
    else
      unless logged_in?
        redirect_to :root 
      end
    end
  end

end
