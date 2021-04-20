class ApplicationController < ActionController::Base
  before_action :set_search_posts_form
  add_flash_types :succes, :info, :warning, :danger  # flashメッセージは notice か alert の２種類しか使えないので他のキーの使用を許可しておく必要がある

  before_action :require_login

  private
  
  def not_authenticated
    redirect_to root_path
  end

  def set_search_posts_form
    @search_form = SearchPostsForm.new(search_post_params) 
  end

  def search_post_params
    params.fetch(:q, {}).permit(:body, :content_body, :username) # fetch(:q, {}) <- views/posts/_search のフォームから送られてきたパラメーター(:q というキーをしている)。 {} はデフォルト値
  end
end
