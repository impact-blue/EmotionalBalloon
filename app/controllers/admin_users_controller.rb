class AdminUsersController < ApplicationController
  before_action :logged_in_admin_user

  def index
    @json_admin_users = AdminUser.all
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(user_params)
    if @admin_user.save
      flash[:success] = "管理画面へようこそ"
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def destroy
    admin_user = AdminUser.find(params[:id])
    admin_user.delete
    redirect_to action: 'index'
  end

  private

  def user_params
    params.require(:admin_user).permit(:name, :email, :password,
     :password_confirmation)
  end

end
