class AdminCustomersController < ApplicationController
  before_action :logged_in_admin_user

  def index
  @order = Order.where.not(user_id: nil)
  end

end
