class ApplicationController < ActionController::Base
  
  add_flash_types :succes, :info, :warning, :danger  # flashメッセージは notice か alert の２種類しか使えないので他のキーの使用を許可しておく必要がある

  before_action :require_login

  protected
  def not_authenticated
    redirect_to root_path
  end
end
