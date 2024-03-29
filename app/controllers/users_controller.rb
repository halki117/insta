class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def index
    @users = User.all.page(params[:page]).order(created_at: :desc) 
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user) # 新規登録後はログイン状態にしておく
      redirect_to root_path, success: 'ユーザーを作成しました'
    else
      flash.now[:danger] = 'ユーザーの作成に失敗しました'
      render :new
    end 
  end

  def show
    @user =  User.find(params[:id])
    @posts = @user.posts # 1人のユーザーが保有する投稿のレコードを全て呼び出す
  end


  private
  def user_params
    params.require(:user).permit(:name, :email ,:password ,:password_confirmation)
  end

  def user_profile_params
    params.require(:user).permit(:profile_photo, :name)
  end
end
