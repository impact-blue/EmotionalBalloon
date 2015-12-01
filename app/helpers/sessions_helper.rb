module SessionsHelper

   def log_in(admin_user)
    session[:admin_user_id] = admin_user.id
  end

end