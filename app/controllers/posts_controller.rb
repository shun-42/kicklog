class PostsController < ApplicationController
  
  
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  
  # 本人確認は編集・更新・削除のみ
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def index
    
    @brand = Brand.find(params[:brand_id])
    @posts = @brand.posts
  end

  def new
    
    @brand = Brand.find(params[:brand_id])
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

  def edit
    
    @post = Post.find(params[:id])
    redirect_to root_path, alert: "権限がありません" unless @post.user == current_user
  end

  def update
    @post = Post.find(params[:id])
    redirect_to root_path, alert: "権限がありません" unless @post.user == current_user
    if @post.update(post_params)
      redirect_to brand_posts_path(@post.brand), notice: "投稿を更新しました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      # ★ここをマイページへのパスに変更します
      redirect_to user_path(current_user), notice: "削除しました"
    else
      redirect_to root_path, alert: "権限がありません"
    end
  end
  
  def show
  
   @post = Post.find(params[:id])
  end


  private
  def ensure_correct_user
    @post = Post.find(params[:id])
    # 投稿者とログインユーザーが違ったら一覧へ追い返す
    unless @post.user == current_user
      redirect_to brand_posts_path(@post.brand), alert: "権限がありません。"
    end
  end
  
  def post_params
    params.require(:post).permit(:content, :image, :spike_name)
  end


end