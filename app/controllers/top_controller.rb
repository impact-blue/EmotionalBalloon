class TopController < ApplicationController
  respond_to :json

  def index
    @products = Product.all.page(params[:page]).per(20).order("created_at DESC")
  end

end