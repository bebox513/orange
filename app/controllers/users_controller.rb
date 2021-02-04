class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @followers = @user.followers
    @followings = @user.followings
    @button = params[:button]
  end
end
