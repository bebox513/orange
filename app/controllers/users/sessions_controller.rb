class Users::SessionsController < Devise::SessionsController
  def new_guest
    role = params[:role].to_i
    user = User.guest(role)
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
