class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = User.first
    
    if @post.save
      redirect_to @post, notice: "投稿しました！"
    else
      # 失敗した理由をログに出力する魔法のコード
      puts "保存に失敗しました！エラー内容: #{@post.errors.full_messages}"
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
  

  private

  def post_params
    params.require(:post).permit(:content, :brand_id, :image) 
  end
end