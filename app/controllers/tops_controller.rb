class TopsController < ApplicationController
  def index
    @posts = Post.all.order(id: "DESC")
    @button = params[:button]
  end

  def show
  end
end
