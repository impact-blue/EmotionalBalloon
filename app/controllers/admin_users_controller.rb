class AdminUsersController < ApplicationController

  def show
    @admin_user = AdminUser.find(params[:id])
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(user_params)
    if @admin_user.save
      redirect_to @admin_user
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
