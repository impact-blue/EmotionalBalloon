class CartsController < ApplicationController

  def show
    @cart = Cart.where(ip: request.remote_ip)
  end

  def register
  end

  def comfirm
  end

  def thanks
  end

  def create_cart
    @cart = Cart.new(cart_params)
    remote_ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    @cart.ip = set_ip
    @cart.flag = 0
    if @cart.save
      redirect_to :back
    else
      render 'show'
    end
  end

  private

  def cart_params
    params.require(:cart).permit(:product_id,:ip)
  end

  def set_ip
    @ip = request.remote_ip
  end

end
