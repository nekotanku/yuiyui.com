class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  def set_current_user
    @current_user=User.find_by(id: session[:user_id])
  end
  
  private
  
  
  def require_user_logged_in
    unless logged_in?
      flash[:danger] = "ログインをすれば利用できます"
      redirect_to login_path
    end
  end
  def counts(user)
    @count_microposts =user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end
    
end
