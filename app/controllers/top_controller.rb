class TopController < ApplicationController

  def index
    @json_ranking_products = Product.all.page(params[:page]).per(5).order("count DESC")
  end

end