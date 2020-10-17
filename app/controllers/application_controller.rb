class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      flash[:danger] = "ログインが必要です！"
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_reviews = user.reviews.count
    @count_shop_likes = user.likes.count
  end

  def forbid_login_user
    if session[:user_id] != nil
      flash[:danger] = "すでにログインしています！"
      redirect_to root_url
    end
  end

end
