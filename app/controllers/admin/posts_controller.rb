class Admin::PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
  end

  # 2. 投稿詳細
  def show
    @post = Post.find(params[:id])
  end

  # 3. 投稿編集画面
  def edit
    @post = Post.find(params[:id])
  end

  # 4. 投稿更新アクション
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_user_posts_path(@post.user), notice: "投稿を更新しました"
    else
      puts "--- 保存失敗: #{@post.errors.full_messages} ---"
      render :edit
    end
  end

  # 5. 投稿削除アクション
  def destroy
    post = Post.find(params[:id])
    user = post.user 
    post.destroy
    redirect_to admin_user_posts_path(user), notice: "投稿を削除しました。"
  end

  def clear_review
    @post = Post.find(params[:id])
   
    if @post.update(trap: nil, kick: nil, sprint: nil, pass_accuracy: nil, durability: nil)
      redirect_to admin_user_posts_path(@post.user), notice: "レビュー評価をクリアしました。"
    else
      redirect_to admin_user_posts_path(@post.user), alert: "削除に失敗しました。"
    end
  end

  private

 
  def post_params
    params.require(:post).permit(:content, :image, :spike_name)
  end
end
