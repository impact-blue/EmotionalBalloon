class AdminOrdersController < ApplicationController
  before_action :logged_in_admin_user
  before_action :set_json_index

  def index

    unless params[:status].present?
      redirect_to "/admin/orders/?status=all" and return
    end

    if params[:per_page].present?
      @per = params[:per_page]
    end

    #検索
    if params[:status] ==  "all" #すべて
        @json_order_list = Order.get_list_all(params[:page],@per,"id ASC",params[:product],params[:category],params[:max],params[:min])
    elsif params[:status] == "unconfirmed" #未入金
        @json_order_list = Order.get_list_by_status("未入金",params[:page],@per,"id ASC",params[:product],params[:category],params[:max],params[:min])
    elsif params[:status] ==  "process" #未発送
        @json_order_list = Order.get_list_by_status("未発送",params[:page],@per,"id ASC",params[:product],params[:category],params[:max],params[:min])
    elsif params[:status] == "complete" #完了
        @json_order_list = Order.get_list_by_status("完了",params[:page],@per,"id ASC",params[:product],params[:category],params[:max],params[:min])
    end

    #CSVダウンロード
    #<a href="/admin/orders.csv/?status=all&page={{data.search_products.current_page}}">CSV</a>
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: "orders-#{Time.now.to_date.to_s}.csv", type: :csv
      end
    end
  end

  def edit
    #detail_productも出す。
    @json_detail_order = Order.includes(order_product_infos: :product).find(params[:id])
    @order_products = @json_detail_order.order_product_infos
    @buyer_info = @json_detail_order.user
    @destination_info = @json_detail_order
  end

  def api
    ActiveRecord::Base.transation do
      if params[:data][:id].nil?
        @order = Order.new(order_params)
      elsif params[:data][:id].present?
        @order = Order.find(prams[:data][:id])
      end

  def import
    Order.import(params[:file])
    redirect_to "/admin/orders?status=all"
  end



    end
  end

  private

  def order_params
    params.require(:order).permit(:price)
  end


end
