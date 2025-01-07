class PostsController < ApplicationController
 

  def index 
    # 降順に並び替え
    @posts = Post.all.order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
      if @post.save
        redirect_to posts_path, notice: "投稿が成功しました。"
        # redirect_to post_path(@post.id)
      else
        @posts = Post.all    
        flash.now[:alert] = "投稿に失敗しました。内容を確認してください。"  
        render :index
      end    
  end

  def edit
    post = Post.find(params[:id])
    unless post.user_id == current_user.id
      redirect_to posts_path
    end
    @post = post
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      #  "flash[:notice] = 'メッセージ内容'"　リクエスト間を超えてメッセージを表示するための仕組み
      flash[:notice] = "編集が成功しました。"
      
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "編集に失敗しました。内容を確認してください。"
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(current_user.id), notice: '投稿を削除しました。'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end


end
