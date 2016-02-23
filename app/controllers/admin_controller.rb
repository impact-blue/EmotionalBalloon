class AdminController < ApplicationController
  before_action :logged_in_admin_user


def index
  t = Time.current
  #今月のやつ
  @orders = Order.where(created_at: Time.now.in_time_zone.all_month)
    @json_sales_orders = 0
    @orders.each do |o|
      @json_sales_orders += o.price
    end
  #当月のやつ


end

end
