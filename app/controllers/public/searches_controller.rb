class Public::SearchesController < ApplicationController

  def index

    @model = params[:model] #検索場所選択 "User" => "user", "Post" => "Post","Group" => "group"
    @query = params[:query] # textfield 検索単語入力
    @method = params[:method] #検索方法選択　完全一致" => "perfect", "前方一致" => "forward", "後方一致" => "backward", "部分一致" => "partial"
    if @model == 'user'
      @search_results = User.search_for(@query, @method)
    elsif @model =='post'
      @search_results = Post.search_for(@query, @method)
    else
      @search_results = Group.search_for(@query, @method)
    end

  end

end


