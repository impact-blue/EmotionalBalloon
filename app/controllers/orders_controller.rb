class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = Order.new
    if @order.save
      redirect_to root_path
    else
      render 'new'
    end
  end

end
