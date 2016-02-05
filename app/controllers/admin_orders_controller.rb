class AdminOrdersController < ApplicationController
  before_action :logged_in_admin_user
  before_action :set_json_index

  def index
    @json_order_list = Order.all.includes(:user).order("created_at ASC")
    unless params[:filter].present?
      redirect_to "/admin/orders/?filter=all"
    end

    if params[:filter] == "unconfirmed"
      @json_order_list = Order.where(order_status: "新着").includes(:user)
    elsif params[:filter] ==  "process"
      @json_order_list = Order.where(order_status: "未発送").includes(:user)
    elsif params[:filter] == "complete"
      @json_order_list = Order.where(order_status: "完了").includes(:user)
    end
  end

  def edit
  end

end
