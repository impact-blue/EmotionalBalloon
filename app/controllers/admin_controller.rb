class AdminController < ApplicationController
  before_action :logged_in_admin_user


  def index
    #売上
      @json_sales_orders = []
      @json_sales_weekly = []
      @json_sales_monthly = []
      current_day_count = Time.zone.now.strftime('%d').to_i #今日の日付のみ取得
      current_day = Time.now
      all_orders = Order.all
      all_users  = User.all
      all_order_product_infos = OrderProductInfo.select("sun_price").all

      #平均顧客単価の求めたい期間を検索
      if params[:filter].blank?
        target_day = Time.local(2015,1,1)
      elsif params[:filter] == "all"
        target_day = Time.local(2015,1,1)
      elsif params[:filter] == "year"
        target_day = current_day.beginning_of_day - 365.days
      elsif params[:filter] == "month"
        target_day = current_day.beginning_of_day - 30.days
      elsif params[:filter] == "day"
        target_day = current_day.beginning_of_day
      end
      #昨日の売上
              yesterday = Hash.new
              day = (current_day -1.day)
              yesterday[:price] = all_order_product_infos.where(created_at: day).pluck(:sum_price).inject(:+)
              yesterday[:count] = all_orders.select("id").where(created_at: day).length
              yesterday[:day]   = day.strftime('%Y/%m/%d')
              @json_sales_yesterday = yesterday
      #週間（7日間）の売上 これは、ハッシュでまとめる
              weekly = Hash.new
              day = (current_day.beginning_of_day - 6.day)
              weekly[:price] = all_order_product_infos.where(created_at: day..current_day).pluck(:sum_price).inject(:+)
              weekly[:count] = all_orders.select("id").where(created_at: day..current_day).length
              weekly[:day]   = "週間"
              @json_sales_weekly = weekly
      #31日間の売上（ハッシュでまとめたやつ）
              monthly = Hash.new
              day = (current_day.beginning_of_day - 30.day)
              monthly[:price] = all_order_product_infos.where(created_at: day..current_day).pluck(:sum_price).inject(:+)
              monthly[:count] = all_orders.select("id").where(created_at: day..current_day).length
              monthly[:day]   = "月間"
              @json_sales_monthly = monthly
      #今年の売上
              all_year = Time.now.all_year
              sales_year = Hash.new
              sales_year[:price]  = all_order_product_infos.where(created_at: all_year).pluck(:sum_price).inject(:+)
              sales_year[:count]  = all_orders.select("id").where(created_at: all_year).length
              @json_sales_year = sales_year

      #当月の売上
        current_day_count.times do |i| #今日の日付の数だけ繰り返す
              @sales_index = all_orders.select("price").where(created_at: current_day.all_day)
              sales = Array.new
              sales << current_day.strftime('%m/%d')
              sales << 0
              #当月の売上
                  @sales_index.each do |o|
                    sales[1] += o.price
                  end
            @json_sales_orders.unshift(sales)
            current_day_count -= 1
            current_day -= 1.day
        end


    #平均顧客単価（合計）
      all_sales = all_orders.select("price").where(created_at: (target_day)..(current_day.end_of_day))
      if all_sales.present?
        sales_info = Hash.new
        sales_info[:count] = all_sales.count
        sales_info[:sum_price] = all_sales.pluck(:price).inject(:+)
        @json_sales_average = sales_info[:sum_price]/sales_info[:count]
      end

    #平均顧客単価（リピート）
      repeat_user = all_users.select("id,repeat_count").where("repeat_count >= ?",2).where(created_at: (target_day)..(current_day.end_of_day))
      repeat_order = all_orders.select("price").where(user_id: repeat_user.ids).where(created_at: (target_day)..(current_day.end_of_day))
      if repeat_order.present?
        sales_info_repeat = Hash.new
        sales_info_repeat[:count] = repeat_order.count
        sales_info_repeat[:sum_price] = repeat_order.pluck(:price).inject(:+)
        @json_repeat_sales_average = sales_info_repeat[:sum_price]/sales_info_repeat[:count]
      end
    #平均顧客単価（新規）
      new_user = all_users.select("id,repeat_count").where("repeat_count = ?",1).where(created_at: (target_day)..(current_day.end_of_day))
      new_order = all_orders.select("price").where(user_id: new_user.ids).where(created_at: (target_day)..(current_day.end_of_day))
      if new_order.present?
        new_sales_info = Hash.new
        new_sales_info[:count] = new_order.count
        new_sales_info[:sum_price] = new_order.pluck(:price).inject(:+)
        @json_new_sales_average = new_sales_info[:sum_price]/new_sales_info[:count]
      end
    #リピート人数（全体）
      @json_repeat_user_count = all_users.select("repeat_user_id,repeat_count").uniq.where("repeat_count >= ?",2).count




    #30日間の売上（月を跨ぐ）
  #  @orders = Order.where(created_at: [30.days.ago.beginning_of_day..Time.now.end_of_day])
  #    @json_sales_orders = 0
  #    @orders.each do |o|
  #      @json_sales_orders += o.price
  #    end
    #@json_sales_orders = Order.where(created_at: @date.strftime("%Y/%m/%d"))
    # order.products.map(&:name).zip(order.order_product_infos.map(&:count))
  #こんな書き方とか

  @chart_data = @json_sales_orders
#<%= column_chart @chart_data , stacked: true , label: "売上", xtitle: "日付", ytitle: "売上"%>



  end #indexの終わり



end

