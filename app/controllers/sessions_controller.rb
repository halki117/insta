class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
        
    if @user = login(params[:email], params[:password])
      redirect_to root_path
    else
      flash.now[:alert] = 'Login 失敗'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  private
  
  def user_session_params
    params.permit(:email, :password)
  end
end
