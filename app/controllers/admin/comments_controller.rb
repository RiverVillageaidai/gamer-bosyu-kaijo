class Admin::CommentsController < ApplicationController
  layout 'admin' #/views/layouts/　にあるapplication.html.erbの代わりにadmin.html.erbを使用する
  before_action :authenticate_admin!

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to request.referer, notice: "コメントを削除しました。"
  end

end
