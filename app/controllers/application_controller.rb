class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def devise_parameter_sanitizer
    if resource_class == CorpUser
      CorpUser::ParameterSanitizer.new(CorpUser, :corp_user, params)
    else
      super
    end
  end
end
