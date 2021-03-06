class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user
  after_filter  :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
  	cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end
  
  def current_user
    if session[:current_user_id]
    @current_user ||= User.find(session[:current_user_id])
  else
    @current_user = nil
  end
  end
  def logged_in?

    current_user != nil
  end
  def authorized?
    if params[:user_id] != nil
      unless params[:user_id] == current_user.id.to_s
        redirect_to "/landing.html" 
      end
    else
      unless logged_in?
        redirect_to "/landing.html"
      end
    end
  end
  def page_params
    @page_number = (params[:page]|| 0).to_i
    @page_size = (params[:limit] || 20).to_i
    @page_offset = @page_number * @page_size
  end
    protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
    
  end
end
