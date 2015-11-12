class ApiController < ApplicationController

  def show
  @product = Product.all
  end
end
