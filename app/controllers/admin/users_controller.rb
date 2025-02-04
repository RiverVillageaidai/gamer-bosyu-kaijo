class Admin::UsersController < ApplicationController
  layout 'admin' #/views/layouts/　にあるapplication.html.erbの代わりにadmin.html.erbを使用する
  before_action :authenticate_admin!

  def index
    @users = User.order(created_at: :desc).page(params[:page])
  end
  
  # ユーザー退会処理admin
  def withdraw
    @user = User.find(params[:id])
    if @user.update(is_active: false) # 論理削除として退会状態に変更
      flash[:alert] ='退会処理が完了しました。'
      redirect_to request.referer
    else
      flash[:alert] ='退会処理に失敗しました。'
      redirect_to request.referer
    end
  end
  
  #ユーザー入会処理（入会復帰）
  def rejoin
    @user = User.find(params[:id])
    if @user.update(is_active: true) 
      flash[:alert] ='入会処理が完了しました。'
      redirect_to request.referer
    else
      flash[:alert] ='入会処理に失敗しました。'
      redirect_to request.referer
    end
  end

end
