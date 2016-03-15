class AdminOrdersController < ApplicationController
  before_action :logged_in_admin_user
  before_action :set_json_index

  def index

    unless params[:status].present?
      redirect_to "/admin/orders/?status=all" and return
    end

    if params[:status] ==  "all"
      @json_order_list = Order.includes(:user,user: :user_names).all.page(params[:page]).per(@page).order("id ASC")
    elsif params[:status] == "unconfirmed"
      @json_order_list = Order.where(order_status: "未入金"  ).page(params[:page]).per(@page).includes(:user,user: :user_names)
    elsif params[:status] ==  "process"
      @json_order_list = Order.where(order_status: "未発送").page(params[:page]).per(@page).includes(:user,user: :user_names)
    elsif params[:status] == "complete"
      @json_order_list = Order.where(order_status: "完了"  ).page(params[:page]).per(@page).includes(:user,user: :user_names)
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
