class Public::GroupMembersController < ApplicationController
  before_action :authenticate_user!

  def create 
    group_member = current_user.group_members.new(group_id: params[:group_id])
    group_member.save
    flash.now[:alert] = "グループに参加しました。" 
    redirect_to request.referer
  end

  def destroy
    group_member = current_user.group_members.find_by(group_id: params[:group_id])
    group_member.destroy
    flash.now[:alert] = "グループから退会しました。" 
    redirect_to request.referer
  end
end
