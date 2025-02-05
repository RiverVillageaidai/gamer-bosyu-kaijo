class Public::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]) # ユーザーの投稿を取得
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
    @user = user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      #  "flash[:notice] = 'メッセージ内容'"　リクエスト間を超えてメッセージを表示するための仕組み
      flash[:notice] = "更新が成功しました。"
     
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "更新に失敗しました。内容を確認してください。"
      @user = User.find(params[:id]) #失敗時にフォームのデフォルト値に現在のデータを表示するため
      render :edit
    end
  end

  # ユーザー退会確認画面
  def deactivate
    @user = User.find(params[:id])
  end

  # ユーザー退会処理
  def withdraw
    @user = User.find(params[:id])
    if @user.update(is_active: false) # 論理削除として退会状態に変更
      reset_session # セッションをリセットしてログアウト（セキュリティ）
      redirect_to root_path, notice: '退会処理が完了しました。'
    else
      render :deactivate, alert: '退会処理に失敗しました。'
    end
  end

  private

  def user_params
      params.require(:user).permit(:name, :email, :birthday, :profile_image, :introduction)
  end
end
