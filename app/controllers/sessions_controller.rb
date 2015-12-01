class SessionsController < ApplicationController
  def new
  end

 def create
    admin_user = AdminUser.find_by(email: params[:session][:email].downcase)
    if admin_user && admin_user.authenticate(params[:session][:password])
      log_in admin_user
    else
       flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

end