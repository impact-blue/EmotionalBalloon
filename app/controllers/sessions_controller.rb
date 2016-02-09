class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to admin_path
    end
  end

  def create

    admin_user = AdminUser.find_by(email: params[:session][:email].downcase)
    if admin_user && admin_user.authenticate(params[:session][:password])
      log_in admin_user
      render json: {data:{result:"success"}}
    else
     flash.now[:danger] = 'Invalid email/password combination'
     render 'new'
   end
  end

  def destroy
    log_out
    redirect_to admin_login_path
  end

end