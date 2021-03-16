class PostsController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @posts = Post.all 
    @users = User.limit(5)
    end
  
end
