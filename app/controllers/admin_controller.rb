class AdminController < ApplicationController
  before_action :logged_in_admin_user


  def index
    #当月の売上
      @json_sales_orders = []
      current_day_count = Time.zone.now.strftime('%d').to_i #今日の日付のみ取得
      current_day = Time.zone.now

      current_day_count.times do  #今日の日付の数だけ繰り返す
        @sales_index = Order.select("price").where(created_at: current_day.all_day)
          sales = Hash.new
          sales[:price] = 0
          sales[:count] = 0
          sales[:day] = current_day.strftime('%Y/%m/%d')

          @sales_index.each do |o|
            sales[:price] += o.price
            sales[:count] += 1
          end

        @json_sales_orders.unshift(sales)
        current_day_count -= 1
        current_day -= 1.day
    end
    #昨日の売上


    #平均顧客単価
      all_sales = Order.select("price").all
      sales_info = Hash.new
      sales_info[:count] = all_sales.count
      sales_info[:sum_price] = all_sales.pluck(:price).inject(:+)
      @json_sales_average = sales_info[:sum_price]/sales_info[:count]









    #30日間の売上（月を跨ぐ）
  #  @orders = Order.where(created_at: [30.days.ago.beginning_of_day..Time.now.end_of_day])
  #    @json_sales_orders = 0
  #    @orders.each do |o|
  #      @json_sales_orders += o.price
  #    end

  #まずは、30日間のみ
    #@date = Time.now

    #@json_sales_orders = Order.where(created_at: @date.strftime("%Y/%m/%d"))
    # order.products.map(&:name).zip(order.order_product_infos.map(&:count))
  #こんな書き方とか
  end



end

