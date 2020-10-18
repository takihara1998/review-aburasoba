class ReviewsController < ApplicationController
  before_action :require_user_logged_in, only: [:create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def show
    @review = Review.find(params[:id])
    @shop = Shop.find_by(id: @review.shop_id)
  end
  
  def create
    @shop = Shop.find(params[:shop_id])
    @review = current_user.reviews.new(review_params)
    if @review.save
      flash[:success] = 'レビューを追加しました。'
      redirect_to @shop  
    else
      flash[:danger] = 'レビューの追加に失敗しました。'
      redirect_back(fallback_location: root_path) 
    end
  end
  
  def edit
    @review = Review.find(params[:id])
  end
  
  def update
    @review = Review.find(params[:id])
    if @review.update(edit_review_params)
      flash[:success] = 'レビューを編集しました。'
      redirect_to @review
    else
      flash.now[:danger] = 'レビューの編集に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @review = Review.find(params[:id])
    @shop = @review.shop
    if @review.destroy
      flash[:success] = "レビューを削除しました。"
      redirect_to @shop  #要検討
    end
  end
  
  private
  
    def review_params
      params.require(:review).permit(:title, :content, :picture_a, :picture_b, :star).merge(shop_id: params[:shop_id])  
    end
    
    def edit_review_params
      params.require(:review).permit(:title, :content, :picture_a, :picture_b, :star)
    end
    
    def correct_user
      @review = current_user.reviews.find_by(id: params[:id])
      unless @review
        flash[:danger] = "権限がありません！"
        redirect_to root_url
      end
    end
end
