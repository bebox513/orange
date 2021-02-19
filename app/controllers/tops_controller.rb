class TopsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(10)

    return unless request.xhr?

    case params[:type]
    when 'posts', 'post', 'user'
      render "tops/#{params[:type]}"
    end
  end

  def show
  end
end
