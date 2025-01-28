class Public::GroupsController < ApplicationController
  before_action :authenticate_user! #ログインしていないユーザーをログインページにリダイレクト
  before_action :ensure_group_owner, only: [:edit, :update] #ユーザーが edit または update アクションにアクセスしたとき ensure_group_ownerメソッド
  
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path, method: :post
    else
      flash.now[:alert] = "グループ作成に失敗しました。" 
      render :new
    end
  end
  
  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:notice] = "グループ編集が成功しました。"
      redirect_to groups_path, method: :post
    else
      flash.now[:alert] = "グループ編集に失敗しました。内容を確認してください。"
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

  # ログインユーザーがグループオーナーか確認するメソッド
  def ensure_group_owner
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path, alert: "権限がありません。"
    end
  end
end
