class TopController < ApplicationController

  def index
    @products = Product.all.page(params[:page]).per(5).order("created_at DESC")
  end

end