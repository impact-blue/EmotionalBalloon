class CartsController < ApplicationController

  def index
    @cart = Cart.where(ip: request.remote_ip)
  end
end
