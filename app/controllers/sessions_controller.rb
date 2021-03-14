class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
  end

  def create
    @user = login(params[:email], params[:password])  # newのページに遷移しすることも考え,createアクション名でもインスタンス変数を設定している。
    
    if @user
      redirect_back_or_to root_path, success: 'ログインしました' # redirect_back_or_to 保存されたURLがある場合そのURLに、ない場合は指定されたURLにリダイレクト
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, success: 'ログアウトしました'
  end

end
