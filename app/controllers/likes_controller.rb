class LikesController < ApplicationController

  def create
    like = Like.create(user_id: current_user.id, post_id: params[:post_id])
    redirect_to root_path
  end
end
