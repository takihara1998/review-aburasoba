class ShopsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :edit, :update]
  
  # 人気順
  def index
    @shops = Shop.all.each do |shop|
      shop.average = shop.average_score
    end
    @shops = @shops.sort_by { |shop| shop.average }.reverse
    @shops = Kaminari.paginate_array(@shops).page(params[:page]).per(15)
  end
  
  def show
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews.order(id: :desc).page(params[:page]).per(15)
    @review = Review.new
  end
  
  def new
    @shop = current_user.shops.build  #form_with
  end

  def create
    @shop = current_user.shops.build(shop_params)
    if @shop.save
      flash[:success] = 'お店を追加しました。'
      redirect_to @shop
    else
      flash.now[:danger] = 'お店の追加に失敗しました。'
      render :new
    end
  end
  
  def edit
    @shop = Shop.find(params[:id])
  end
  
  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      flash[:success] = "お店の情報を編集しました。"
      redirect_to @shop
    else
      flash.now[:danger] = "お店の情報の編集に失敗しました。"
      render :edit
    end
  end

  
  def search
    if params[:name].present?
      @search_shops = Shop.order(id: :desc).where('name LIKE ?', "%#{params[:name]}%")
        if @search_shops.count == 0
          flash.now[:danger] = "お店が見つかりませんでした。"
        else
          flash.now[:success] = "#{@search_shops.count}件のお店が見つかりました。"
        end
    elsif params[:address].present?
      @search_shops = Shop.order(id: :desc).where("address LIKE ?", "%#{params[:address]}%")
        if @search_shops.count == 0
          flash.now[:danger] = "お店が見つかりませんでした。"
        else
          flash.now[:success] = "#{@search_shops.count}件のお店が見つかりました。"
        end
    else  
      @search_shops = Shop.none
    end
  end
  
  # 登録順
  def created_at
    @shops = Shop.order(id: :desc).page(params[:page]).per(15)
  end


  private

    def shop_params
      params.require(:shop).permit(:name, :shop_picture, :address, :open_hour, :holiday, :tel)
    end

end
