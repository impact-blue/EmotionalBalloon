class TopController < ApplicationController
  before_action :set_json_categories

  def index
    @json_ranking_products = Product.all.page(params[:page]).per(5).order("count DESC")
  end

end