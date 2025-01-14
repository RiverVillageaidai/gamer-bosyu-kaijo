class ApplicationController < ActionController::Base

  # devise利用の機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersメソッドが実行される記述
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログインしていないユーザーは top とabout以外にアクセスするとログイン画面に推移する,admin_controller? メソッドの結果が true の場合、認証をスキップ
  before_action :authenticate_user!, except: [:top, :about],unless: :admin_controller?

  private
 
  def admin_controller?
    self.class.module_parent_name == 'Admin' #現在のコントローラークラスが"Admin"モジュールに属していれば　true
  end

  protected

  # ユーザーログイン時にname を許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end