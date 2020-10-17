class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update]
  before_action :forbid_login_user, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.order(id: :desc).page(params[:page]).per(15)
    counts(@user)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      session[:user_id] = @user.id
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールを編集しました。"
      redirect_to @user
    else
      flash.now[:danger] = "プロフィールの編集に失敗しました。"
      render :edit
    end
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.order(id: :desc).page(params[:page]).per(15)
    counts(@user)
  end
  
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :picture, :password, :introduction, :password_confirmation)
    end
    
    def correct_user
      @user = User.find(params[:id])
      if current_user.id != @user.id
        flash[:danger] = "権限がありません！"
        redirect_to root_url
      end
    end
end
