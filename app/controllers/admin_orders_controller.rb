class AdminOrdersController < ApplicationController
  before_action :logged_in_admin_user
  before_action :set_json_index

  def index

    unless params[:status].present?
      redirect_to "/admin/orders/?status=all" and return
    end

    if params[:per_page].present?
      @page = params[:per_page]
    end

    #検索
    if params[:status] ==  "all" #すべて
      if (params[:max] && params[:min]).present? #価格絞り込み
        @json_order_list = Order.includes(:user,user: :user_names).where("price >= ? AND price <= ?", params[:min],params[:max]).page(params[:page]).per(@page).order("id ASC")
      elsif params[:category].present? #カテゴリーで絞込み
        @json_order_list = Order.joins(:products).includes(:user,user: :user_names).where('products.category_id = ?', params[:category]).page(params[:page]).per(@page).order("id ASC")
      elsif params[:product].present? #商品番号で検索
        @json_order_list = Order.joins(:products).includes(:user,user: :user_names).where('products.id = ?', params[:product]).page(params[:page]).per(@page).order("id ASC")
      else
        @json_order_list = Order.includes(:user,user: :user_names).all.page(params[:page]).per(@page).order("id ASC")
      end
    elsif params[:status] == "unconfirmed" #未入金
      if (params[:max] && params[:min]).present? #価格で絞込み
        @json_order_list = Order.where(order_status: "未入金"  ).where("price >= ? AND price <= ?", params[:min],params[:max]).page(params[:page]).per(@page).includes(:user,user: :user_names).order("id ASC")
      elsif params[:category].present? #カテゴリーで絞込み
        @json_order_list = Order.joins(:products).where(order_status: "未入金"  ).where('products.category_id = ?', params[:category]).page(params[:page]).per(@page).includes(:user,user: :user_names).order("id ASC")
      elsif params[:product].present? #商品番号で検索
        @json_order_list = Order.joins(:products).where(order_status: "未入金"  ).where('products.id = ?', params[:product]).page(params[:page]).per(@page).includes(:user,user: :user_names).order("id ASC")
      else
        @json_order_list = Order.where(order_status: "未入金"  ).page(params[:page]).per(@page).includes(:user,user: :user_names).order("id ASC")
      end
    elsif params[:status] ==  "process" #未発送
      if (params[:max] && params[:min]).present? #価格で絞込み
        @json_order_list = Order.where(order_status: "未発送").where("price >= ? AND price <= ?", params[:min],params[:max]).page(params[:page]).per(@page).includes(:user,user: :user_names)
      elsif params[:category].present? #カテゴリーで絞込み
        @json_order_list = Order.joins(:products).where(order_status: "未発送").where('products.category_id = ?', params[:category]).page(params[:page]).per(@page).includes(:user,user: :user_names).order("id ASC")
      elsif params[:product].present?
        @json_order_list = Order.joins(:products).where(order_status: "未発送").where('products.id = ?', params[:product]).page(params[:page]).per(@page).includes(:user,user: :user_names).order("id ASC")
      else
        @json_order_list = Order.where(order_status: "未発送").page(params[:page]).per(@page).includes(:user,user: :user_names).order("id ASC")
      end
    elsif params[:status] == "complete" #完了
      if (params[:max] && params[:min]).present? #価格で絞込み
        @json_order_list = Order.where(order_status: "完了"  ).where("price >= ? AND price <= ?", params[:min],params[:max]).page(params[:page]).per(@page).includes(:user,user: :user_names)
      elsif params[:category].present? #カテゴリーで絞込み
        @json_order_list = Order.joins(:products).where(order_status: "完了"  ).where('products.category_id = ?', params[:category]).page(params[:page]).per(@page).includes(:user,user: :user_names).order("id ASC")
      elsif params[:product].present?
        @json_order_list = Order.joins(:products).where(order_status: "完了"  ).where('products.id = ?', params[:product]).page(params[:page]).per(@page).includes(:user,user: :user_names).order("id ASC")
      else
        @json_order_list = Order.where(order_status: "完了"  ).page(params[:page]).per(@page).includes(:user,user: :user_names).order("id ASC")
      end
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
