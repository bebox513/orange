class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @comment = Comment.find(prams[:id])
    @comment.destroy
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
