class AdminOrdersController < ApplicationController
  before_action :logged_in_admin_user
  before_action :set_json_index

  def index
    @json_order_list = Order.select("id,payment_info,order_status,created_at,price,user_id").includes(:user,user: :user_names).order("created_at ASC")
    unless params[:filter].present?
      redirect_to "/admin/orders/?filter=all" and return
    end

    if params[:filter] == "unconfirmed"
      @json_order_list = Order.where(order_status: "未入金"  ).includes(:user,user: :user_names)
    elsif params[:filter] ==  "process"
      @json_order_list = Order.where(order_status: "未発送").includes(:user,user: :user_names)
    elsif params[:filter] == "complete"
      @json_order_list = Order.where(order_status: "完了"  ).includes(:user,user: :user_names)
    end

    #CSVダウンロード
    #<a href="/admin/orders.csv/?filter=all&page={{data.search_products.current_page}}">CSV</a>
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
    redirect_to "/admin/orders?filter=all"
  end



    end
  end

  private

  def order_params
    params.require(:order).permit(:price)
  end


end
