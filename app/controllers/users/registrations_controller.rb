# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :ensure_correct_user, only: [:edit, :update]


  protected

  def ensure_correct_user
    # ログインしていない場合はログイン画面へ
    if current_user.nil?
      redirect_to new_user_session_path
      return
    end

    # もしURLにIDが含まれている場合、そのIDが自分自身かチェックする
    # ※Deviseのパスは通常IDを含みませんが、もし含める設定にしている場合はここが効きます
    if params[:id].present? && params[:id].to_i != current_user.id
      redirect_to user_path(current_user), alert: "他のユーザーの編集はできません。"
    end
  end

  def after_update_path_for(resource)
    brands_path # 更新後に遷移させたいパス
  end
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
