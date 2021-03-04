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

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to "/posts/#{params[:id]}"
    else
      redirect_to "/posts/#{params[:id]}/edit"
    end
  end

  def destroy
    post = Post.find(params[:id])
    if current_user == post.user
      post.destroy
      redirect_to "/"
    end
  end

  def search
    if params[:content].present?
      @posts = Post.where('content LIKE ?', "%#{params[:content]}%")
      @posts = @posts.page(params[:page]).order(id: "DESC").per(10)
    else
      @posts = Post.none
    end
  end

  def post_params
    params.require(:post).permit(:content, :user_id, :img)
  end
end
