class PostsController < ApplicationController
  
  
  before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  
  # 本人確認は編集・更新・削除のみ
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def index
    # (ブランドの取得処理はそのまま)
    if params[:brand_id].match?(/^\d+$/)
      @brand = Brand.find_by(id: params[:brand_id])
    else
      @brand = Brand.where("LOWER(name) = ?", params[:brand_id].downcase).first
    end

    if @brand
      @posts = @brand.posts
      # プレースタイルで絞り込む処理を追加
      if params[:play_style].present?
        # PostはUserに属しているので、joinsで結合して絞り込みます
        @posts = @posts.joins(:user).where(users: { play_style: params[:play_style] })
      end
      
    else
      flash[:alert] = "ブランド「#{params[:brand_id]}」は見つかりませんでした。 "
      redirect_to root_path
    end
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
    redirect_to root_path, notice: "権限がありません" unless @post.user == current_user
  end

  def update
    @post = Post.find(params[:id])
    redirect_to root_path, alert: "権限がありません" unless @post.user == current_user
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "投稿を更新しました！"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user == current_user
      @post.destroy
      redirect_to user_path(current_user), notice: "削除しました"
    else
      redirect_to root_path, notice: "権限がありません"
    end
  end
  
  def show
  
   @post = Post.find(params[:id])
   @post_comment = PostComment.new
  end

  def search
    @posts = Post.search_for(params[:content], params[:method], params[:category])
    @brand = @posts.present? ? @posts.first.brand : nil
  end


  private
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])

    # 1. 投稿自体が存在しない場合
    if @post.nil?
      redirect_to brands_path, notice: "投稿が見つかりませんでした。"
      return
    end

    # 2. 投稿者とログインユーザーが一致しない場合
    unless @post.user == current_user
      redirect_to brands_path, notice: "権限がありません。"
    end
  end

  def post_params
    params.require(:post).permit(:content, :image, :spike_name, :trap, :kick, :sprint, :pass_accuracy, :durability)
  end

  

end