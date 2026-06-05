# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  # ログインに失敗した際のアクションをカスタマイズ
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  rescue StandardError => e
    # 空欄の場合などのエラー処理
    if params[:user][:email].blank? || params[:user][:password].blank?
      flash.now[:alert] = "メールアドレスまたはパスワードを入力してください"
      render :new, status: :unprocessable_entity
    else
      # 通常の認証失敗（ID/PASS間違い）
      super
    end
  end
end