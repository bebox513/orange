class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to "/posts/new"
    else
      redirect_to "/posts/new"
    end
  end

  def search
    if params[:content].present?
      @posts = Post.where('content LIKE ?', "%#{params[:content]}%")
    else
      @posts = Post.none
    end    
  end

  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end
