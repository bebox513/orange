class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @followers = @user.followers
    @followings = @user.followings
    @posts = @user.posts.order(id: "DESC")
    @button = params[:button]
  end
end
