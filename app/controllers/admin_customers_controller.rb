class AdminCustomersController < ApplicationController
  before_action :logged_in_admin_user
  layout 'admin_header'

  def index
  @order = Order.where.not(user_id: nil)
  end

  private

  def logged_in_admin_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to admin_login_path
    end
  end

end
