class AdminOrdersController < ApplicationController
  before_action :logged_in_admin_user
  before_action :set_json_index

  def index
    @json_order_list = Order.all.includes(:user)
  end

  def edit
    
  end

end
