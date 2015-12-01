module SessionsHelper

  def log_in(admin_user)
  session[:admin_user_id] = admin_user.id
  end

    # 現在ログインしているユーザーを返す (ユーザーがログイン中の場合のみ)
  def current_admin_user
      @current_admin_user ||= AdminUser.find_by(id: session[:admin_user_id])
  end

   # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_admin_user.nil?
  end
  # 現在のユーザーがログアウトする
  def log_out
    session.delete(:admin_user_id)
    @current_admin_user = nil
  end

end
