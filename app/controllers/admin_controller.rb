class AdminController < ApplicationController
  before_action :logged_in_admin_user


  def index
    #当月の売上
      @json_sales_orders = []
      current_day_count = Time.zone.now.strftime('%d').to_i
      current_day = Time.zone.now

      current_day_count.times do
        @sales_index = Order.where(created_at: current_day.all_day)
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
    #当月の売り上げここまで

    #30日間の売上（月を跨ぐ）
  #  @orders = Order.where(created_at: [30.days.ago.beginning_of_day..Time.now.end_of_day])
  #    @json_sales_orders = 0
  #    @orders.each do |o|
  #      @json_sales_orders += o.price
  #    end

  #まずは、30日間のみ
    #@date = Time.now

    #@json_sales_orders = Order.where(created_at: @date.strftime("%Y/%m/%d"))

      @card_mail_content = MailContent.find(1)
      @order = Order.find(1)
      @count ="個数"

      # order.products.map(&:name).zip(order.order_product_infos.map(&:count))
  #こんな書き方とか
  end



end

