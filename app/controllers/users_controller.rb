class UsersController < ApplicationController
 
  before_action :authenticate_user!
  
 
  before_action :ensure_correct_user, only: [:show, :edit, :update, :destroy_account]

  def edit
    @user = User.find(params[:id])
    ensure_correct_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to brands_path, notice: "更新しました。"
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    if @user != current_user
      redirect_to user_path(current_user), notice: "他のユーザーのページにはアクセスできません。"
      return
    end
  end
  
  

  def destroy_account
    @user = User.find(params[:id])
    @user.destroy 
    reset_session 
    redirect_to new_user_registration_path, notice: "退会が完了しました。ご利用ありがとうございました。"
  end

  private

  def user_params
    params.require(:user).permit(:email, :position, :password, :password_confirmation, :nickname, :play_style)
  end

  # 本人確認メソッド
 def ensure_correct_user
    # 1. ログインチェック
    if current_user.nil?
      redirect_to new_user_session_path, notice: "ログインしてください。"
      return
    end

    # 2. 本人確認（ログインしているユーザーIDとURLのIDが一致するか）
    if params[:id].present? && params[:id].to_i != current_user.id
      redirect_to user_path(current_user), notice: "他のユーザーのページにはアクセスできません。"
    end
  end

end
