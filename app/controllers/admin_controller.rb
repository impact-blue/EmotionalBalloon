class AdminController < ApplicationController
  before_action :logged_in_admin_user


def index
  @new = Order.where(order_status: 10).count #新規受付
  @complete = Order.where(order_status: 30).count

  @no_stocks = Product.where(stocks: 0).count
end

end
