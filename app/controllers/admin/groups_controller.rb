class Admin::GroupsController < ApplicationController
  layout 'admin' #/views/layouts/　にあるapplication.html.erbの代わりにadmin.html.erbを使用する
  before_action :authenticate_admin!
  
  def index
    @groups = Group.all
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "グループを削除しました。"
    redirect_to admin_groups_path
  end
end
