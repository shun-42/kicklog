class UsersController < ApplicationController
 
  before_action :authenticate_user!
  
 
  before_action :ensure_correct_user, only: [:show, :edit, :update, :destroy_account]

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to brands_path, notice: "更新しました。"
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    if @user != current_user
      redirect_to user_path(current_user), alert: "他のユーザーのページにはアクセスできません。"
      return
    end
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
    # 1. ログインしていない場合はログインページへ飛ばす
    if current_user.nil?
      redirect_to new_user_session_path, alert: "ログインしてください。"
      return
    end

    # 2. ログインしている場合のみ、本人かどうかをチェックする
    if params[:id].to_i != current_user.id
      redirect_to root_path, alert: "他人のデータにはアクセスできません。"
    end
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    # 本人以外ならリダイレクトする処理をここに戻します
    unless @user == current_user
      redirect_to user_path(current_user), alert: "他のユーザーのページにはアクセスできません。"
    end
  end

end
