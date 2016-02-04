class AdminUsersController < ApplicationController
    before_action :logged_in_admin_user
  layout 'header_admin'
  def show
    @admin_user = AdminUser.find(params[:id])
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(user_params)
    if @admin_user.save
      login @admin_user
      flash[:success] = "管理画面へようこそ"
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:admin_user).permit(:name, :email, :password,
     :password_confirmation)
  end

end
