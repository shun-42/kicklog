class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # 会員登録(sign_up)の際に、nameのデータ操作を許可する
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end