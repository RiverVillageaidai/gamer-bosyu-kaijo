class Public::GroupJoinRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    group_join_request = current_user.group_join_requests.new(group_id: params[:group_id])
    group_join_request.save
    redirect_to request.referer, notice: "グループへの参加申請をしました"
  end

  def destroy
    group_join_request = current_user.group_join_requests.find_by(group_id: params[:group_id])
    group_join_request.destroy
    redirect_to request.referer, alert: "グループへの参加申請を取消しました"
  end
end
