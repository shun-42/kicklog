class UsersController < ApplicationController

  # 1. ログインしていない場合はログイン画面へ飛ばす
  before_action :authenticate_user!
  
  # 2. 本人確認用のメソッドを呼び出す（show と destroy_account に適用）
  before_action :ensure_correct_user, only: [:show, :destroy_account]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  def destroy_account
    @user = User.find(params[:id])
    @user.destroy # 物理削除
    reset_session # セッションを完全に破棄してログアウトさせる
    redirect_to new_user_registration_path, notice: "退会が完了しました。ご利用ありがとうございました。"
  end

  private

  # 本人確認メソッド
  def ensure_correct_user
    # URLのIDとログイン中のユーザーIDを比較
    # 注意: params[:id]は文字列なので、整数に変換して比較します
    if params[:id].to_i != current_user.id
      redirect_to root_path, alert: "他人のデータにはアクセスできません。"
    end
  end


end
