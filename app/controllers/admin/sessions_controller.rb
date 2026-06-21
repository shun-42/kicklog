class Admin::SessionsController < Devise::SessionsController

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    
    # ここで明示的に notice をセットしてリダイレクトさせる
    redirect_to after_sign_in_path_for(resource), notice: "ログインしました"
  end

  def destroy
    # ログアウトを実行し、メッセージをセットしてリダイレクト
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    
    # ここで明示的に notice を渡す
    redirect_to new_admin_session_path, notice: "ログアウトしました"
  end

  def after_sign_in_path_for(resource)
    admin_users_path
  end

  def after_sign_out_path_for(resource_or_scope)
      new_admin_session_path
  end

end
  

