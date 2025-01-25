class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:user_id])
    current_user.follow(user) #フォローするメソッド呼び出し
    redirect_to user_path(user)
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user) # フォロー解除メソッド呼び出し
    redirect_to user_path(user)
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings # フォローしている一覧
  end
  
  def followers
    user = User.find(params[:id])
    @users = user.followers #フォローされている一覧
  end

end
