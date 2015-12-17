class TopController < ApplicationController
  respond_to :json

  def index
    @products = Product.all
  end

end