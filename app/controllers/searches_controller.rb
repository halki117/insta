class SearchesController < ApplicationController

  def index
    posts = Post.joins(:user, :comment).where(['description LIKE(?) OR comment LIKE(?) OR name LIKE(?)', "%#{params[:search_description]}%", "%#{params[:search_comment]}%", "%#{params[:search_user]}%"])
  end
end