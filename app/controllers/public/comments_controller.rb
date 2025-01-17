class Public::CommentsController < ApplicationController

  def create 
    post = Post.find(params[:post_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to request.referer, notice: "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
