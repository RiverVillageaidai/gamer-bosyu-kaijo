class PostsController < ApplicationController
 

  def index
    @posts = Post.all
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
  end

  def update
    
  end

  def destroy
    
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end


end
