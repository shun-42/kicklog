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
    # updateメソッドの戻り値を確認し、失敗したらエラーを表示する
    if @post.update(post_params)
      redirect_to admin_user_posts_path(@post.user), notice: "投稿を更新しました"
    else
      # 失敗したとき、コンソールにエラー内容を出力する
      puts "--- 保存失敗: #{@post.errors.full_messages} ---"
      render :edit
    end
  end

  # 5. 投稿削除アクション
  def destroy
    post = Post.find(params[:id])
    user = post.user # 削除後に戻るユーザー情報を先に確保
    post.destroy
    redirect_to admin_user_posts_path(user), notice: "投稿を削除しました。"
  end

  private

  # Strong Parameters（編集・更新を許可する項目）
  def post_params
    params.require(:post).permit(:content, :image, :spike_name)
  end
end
