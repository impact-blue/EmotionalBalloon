class AdminCustomersController < ApplicationController
  before_action :logged_in_admin_user

  def index
    @json_customer_list = User.all.page(params[:page]).per(@page).order("created_at ASC")
  end

end
