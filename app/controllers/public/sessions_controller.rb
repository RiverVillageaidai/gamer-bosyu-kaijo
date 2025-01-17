# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  
  # devise利用の機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersメソッドが実行される記述
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :reject_user, only: [:create]

 

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

   protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def reject_user
    @user = User.find_by(email: params[:user][:email]) #params[:モデル名][:カラム名]受け取ったemailに一致するユーザーを User モデルから検索
    # find_by メソッド:該当するレコードがあればそれを返し、なければ nil
    if @user #@user が nil でない（ユーザーが見つかった）場合
      if @user.valid_password?(params[:user][:password]) && (@user.is_active == false)
        flash[:alert] = "既に退会しています。新規登録してください。"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "passwordが間違っています。"
      end
    end
  end

    # ユーザーログイン時にname を許可
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
    
end
