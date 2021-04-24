class PostsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index
    @posts = if current_user
      current_user.feed.includes(:user).page(params[:page]).order(created_at: :desc)
      # Post.where(user_id: current_user.following_ids << current_user.id ).includes(:user).page(params[:page]).order(created_at: :desc)
    else
      Post.all.includes(:user).page(params[:page]).order(created_at: :desc)
    end
    # @posts = Post.all.includes(:user).order(created_at: :desc).page(params[:page])
    # pageメソッド page(n)とすることでnページ目のレコードを取得(デフォルトでは1ページ25レコードとなる)
    # 1ページ15件表示にしたいので、設定ファイル(config/initializers/kaminari_config.rb)内で設定

    @users = User.recent(5)

  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, success: '投稿しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path, success: '投稿を更新しました'
    else
      flash.now[:danger] = '投稿の更新に失敗しました'
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, success: '投稿を削除しました'
  end

  def search
    @posts = @search_form.search.includes(:user).page(params[:page])
    # @search_form <- application.controller内で定義してある.    search <- SearchPostsFormクラスで定義しているメソッド
  end

  private

  def post_params
    params.require(:post).permit(:description, images: [])
  end
  
end
