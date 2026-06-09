class PostCommentsController < ApplicationController
  def create
    # 投稿を探す
    post = Post.find(params[:post_id])
    # ログインユーザーのコメントとして保存
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    # 投稿詳細画面へ戻る
    redirect_to post_path(post)
  end

  def destroy
    # コメントを探して削除
    PostComment.find(params[:id]).destroy
    # 投稿詳細画面へ戻る
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
