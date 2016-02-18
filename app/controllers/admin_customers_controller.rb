class AdminCustomersController < ApplicationController
  before_action :logged_in_admin_user

  def index
    @json_customer_list = User.all.includes(:user_names).page(params[:page]).per(20).order("created_at ASC")
  end

end
