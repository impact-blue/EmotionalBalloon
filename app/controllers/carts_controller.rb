class CartsController < ApplicationController

  def show
    @cart = Cart.where(ip: request.remote_ip)
  end

  def register
  end

  def comfirm
  end

  def api
    @product = Cart.new(cart_params)
    success = {data:{result: "success"}}
    if @product.save
     # redirect_to carts_thanks_path
      render json: success
    else
      redirect_to carts_thanks_path
    end
  end

  def thanks
  end

  private

  def cart_params
    params.require(:cart).permit(:product_id)
  end



end
