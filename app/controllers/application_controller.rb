class ApplicationController < ActionController::Base

  # devise利用の機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersメソッドが実行される記述
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # ユーザーログイン時にname を許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end