class ShopsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create]
  
  def index
    @shops = Shop.order(id: :desc).page(params[:page])
  end
  
  def show
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews
    @review = Review.new
  end
  
  def new
    @shop = current_user.shops.build  #form_with
  end

  def create
    @shop = current_user.shops.build(shop_params)
    if @shop.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to @shop
    else
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render :new
    end
  end


  private

    def shop_params
      params.require(:shop).permit(:name, :picture, :address, :open_hour, :holiday, :tel)
    end

end
