class UsersController < ApplicationController

  # ログイン必須にするが、showアクションだけは例外にする
  before_action :authenticate_user!, except: [:show] 
  
  # 本人確認は show と destroy_account に適用したいが、
  # show はログインしていなくても見られるようにするなら、以下のように調整が必要です
  before_action :ensure_correct_user, only: [:edit, :update, :destroy_account]

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
