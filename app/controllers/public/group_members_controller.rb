class Public::GroupMembersController < ApplicationController
  before_action :authenticate_user!

  def create 
    @group = Group.find(params[:group_id])
    @group_join_request = GroupJoinRequest.find(params[:group_join_request_id])
    user = User.find(@group_join_request.user_id)
    # グループオーナーが参加できないようにする
    if @group.owner_id == user.id
      flash[:alert] = "グループオーナーはグループに参加できません。"
      redirect_to request.referer and return
    end
    @group_member = GroupMember.create(user_id: @group_join_request.user_id, group_id: params[:group_id])
    @group_join_request.destroy
    flash[:alert] = "#{user.name} さんがグループに参加しました。" 
    redirect_to request.referer
  end

  def destroy
    group_member = current_user.group_members.find_by(group_id: params[:group_id])
    group_member.destroy
    flash.now[:alert] = "グループから退会しました。" 
    redirect_to request.referer
  end
end
