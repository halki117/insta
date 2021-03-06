class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

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

  private
  def user_params
    params.require(:user).permit(:name, :email ,:password ,:password_confirmation)
  end
end
