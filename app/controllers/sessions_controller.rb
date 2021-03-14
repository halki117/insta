class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
  end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to(root_path, notice: 'Login successful')
      flash[:notice] = "ログインしました"
    else
      flash.now[:alert] = 'ログインに失敗しました'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

end
