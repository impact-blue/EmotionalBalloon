class ApiController < ApplicationController

  def get_json
    @products = Product.all
    render json: @products
  end

end
