class UsersController < ApplicationController
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
end
