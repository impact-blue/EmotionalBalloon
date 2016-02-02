class TopController < ApplicationController

  def index
    @products = Product.all.page(params[:page]).per(20).order("created_at DESC")
  end

end