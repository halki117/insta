class CommentsController < ApplicationController
  
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save
    redirect_back_or_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
