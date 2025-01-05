# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

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

  def reject_user
    @user = User.find_by(email: params[:user][:email]) #params[:モデル名][:カラム名]受け取ったemailに一致するユーザーを User モデルから検索
    # find_by メソッド:該当するレコードがあればそれを返し、なければ nil
    if @user #@user が nil でない（ユーザーが見つかった）場合
      if @user.valid_password?(params[:user][:password]) && (@user.is_active == true)
        flash[:alert] = "パスワードが間違っているか、既に退会しています。"
        redirect_to new_user_registration
      else

      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
