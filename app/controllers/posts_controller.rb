class PostsController < ApplicationController
  def index
    # どのブランドの投稿か特定
    @brand = Brand.find(params[:brand_id])
    # そのブランドの投稿だけを抽出
    @posts = @brand.posts
  end

  def new
    # URLの brand_id からブランドを取得
    @brand = Brand.find(params[:brand_id])
    # そのブランドに紐づく新しい投稿を作成
    @post = @brand.posts.new
  end

  def create
    @brand = Brand.find(params[:brand_id])
    @post = @brand.posts.new(post_params)
    @post.user = current_user
    
    if @post.save
      redirect_to brand_posts_path(@brand), notice: "投稿しました！"
    else
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:content) # 必要なカラムを許可
  end
end