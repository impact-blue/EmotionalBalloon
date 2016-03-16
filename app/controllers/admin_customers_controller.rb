class AdminCustomersController < ApplicationController
  before_action :logged_in_admin_user

  def index

    if params[:per_page].present?
      @page = params[:per_page]
    else
      @page = 20
    end

    @json_customer_list = User.all.includes(:user_names).page(params[:page]).per(@page).order("created_at ASC")
  end

  def show
    @json_detail_customer = User.find(params[:id])
  end
end
