class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    root_path
  end

  def general_user_signed_in
    if user_signed_in?
      if current_user.role == 1
        redirect_to "/"
      end
    end
  end
  def facility_user_signed_in
    if user_signed_in?
      if current_user.role == 2
        redirect_to "/"
      end
    end
  end
  def manager_user_signed_in
    if user_signed_in?
      if current_user.role == 3
        redirect_to "/"
      end
    end
  end

  def integer_string?(str)
    Integer(str)
    true
  rescue ArgumentError
    false
  end

  protected
  def configure_permitted_parameters
    added_attrs = [ :name, :email, :password, :password_confirmation, :avatar, :text, :role ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
