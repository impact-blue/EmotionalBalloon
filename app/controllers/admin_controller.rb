class AdminController < ApplicationController
  before_action :logged_in_admin_user


def index
  #当月の売上
 # @json_sales_orders = {"day" =>  "" , "price" => "","count" => ""}
 # @json_sales_orders_index = Order.where(created_at: Time.now.all_day)
 #   @json_sales_orders_price = 0
 #   @json_sales_orders.each do |o|
 #     @json_sales_orders_price += o.price
 #     @json_sales_orders.count + 1
 #   end
  #30日間の売上（月を跨ぐ）
#  @orders = Order.where(created_at: [30.days.ago.beginning_of_day..Time.now.end_of_day])
#    @json_sales_orders = 0
#    @orders.each do |o|
#      @json_sales_orders += o.price
#    end

#まずは、30日間のみ
@date = Time.now

  @json_sales_orders = Order.where(created_at: @date.strftime("%Y/%m/%d"))

end

end
