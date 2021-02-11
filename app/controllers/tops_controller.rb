class TopsController < ApplicationController
  def index
    @posts = Post.all.order(id: "DESC")
  end

  def show
  end
end
