class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  
  def show
    @review = Review.find(params[:id])
  end
  
  def create
    @shop = Shop.find(params[:shop_id])
    @review = current_user.reviews.new(review_params)
    if @review.save
      flash[:success] = 'レビューを追加しました。'
      redirect_to @shop  
    else
      flash.now[:danger] = 'レビューの追加に失敗しました。'
      render "shops/show"  
    end
  end
  
  private
    def review_params
      params.require(:review).permit(:title, :content, :picture_a, :picture_b, :star).merge(shop_id: params[:shop_id])  
    end
end
