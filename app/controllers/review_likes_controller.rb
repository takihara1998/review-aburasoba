class ReviewLikesController < ApplicationController
  before_action :require_user_logged_in

  def create
    review = Review.find(params[:review_id])  #??
    current_user.good(review)
    flash[:success] = 'レビューにいいねしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    review = Review.find(params[:review_id])
    current_user.not_good(review)
    flash[:success] = 'レビューへのいいねを取り消しました。'
    redirect_back(fallback_location: root_path)
  end
end
