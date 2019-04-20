class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  def set_current_user
    @current_user=User.find_by(id: session[:user_id])
  end
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_path
    end
  end
end
