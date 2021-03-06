class ShopLikesController < ApplicationController
  before_action :require_user_logged_in

  def create
    shop = Shop.find(params[:shop_id])
    current_user.like(shop)
    flash[:success] = 'お店にいいねしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    shop = Shop.find(params[:shop_id])
    current_user.unlike(shop)
    flash[:success] = 'お店へのいいねを取り消しました。'
    redirect_back(fallback_location: root_path)
  end
end
