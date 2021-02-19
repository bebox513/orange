class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @followers = @user.followers
    @followings = @user.followings
    @posts = @user.posts.order(id: "DESC")

    return unless request.xhr?

    case params[:type]
    when 'followings', 'followers', 'posts'
      render "users/#{params[:type]}"
    when 'following', 'unfollow'
      render "relationships/#{params[:type]}"
    end
  end

  def search
    if params[:name].present?
      @users = User.where('name LIKE ?', "%#{params[:name]}%")
    else
      @users = User.none
    end
  end
end
