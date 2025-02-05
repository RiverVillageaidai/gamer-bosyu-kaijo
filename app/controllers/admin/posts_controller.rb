class Admin::PostsController < ApplicationController
  layout 'admin' #/views/layouts/　にあるapplication.html.erbの代わりにadmin.html.erbを使用する
  before_action :authenticate_admin!

  def index
    @posts = Post.order(created_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path, notice: '投稿を削除しました。'
  end

end
