class PostsController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @user = User.first
  end
  
end
