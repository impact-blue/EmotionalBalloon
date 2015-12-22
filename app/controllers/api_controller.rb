class ApiController < ApplicationController
#TODO before_action
#出力例http://localhost:3000/api/new.json?page=2&price=>100
  def apis_product_search
    min = params[:min]
    max = params[:max]
    price = params[:price]

    if min.present? && max.present?
      @products = Product.where('price >= ? AND price <= ?',params[:min],params[:max]).page(params[:page]).per(3).order("created_at DESC")
      @current_page = params[:page].to_i
    elsif min.present?
      @products = Product.where('price >= ? ',params[:min]).page(params[:page]).per(3).order("created_at DESC")
      @current_page = params[:page].to_i
    elsif max.present?
      @products = Product.where('price <= ? ',params[:max]).page(params[:page]).per(3).order("created_at DESC")
      @current_page = params[:page].to_i
    else
      @products = Product.page(params[:page]).per(3).order("created_at DESC")
      @current_page = params[:page].to_i
    end
  end

  def ranking
    @products = Product.page(params[:page]).per(3).order("created_at DESC")
    @current_page = params[:page].to_i
  end
#http://localhost:3000/api/budget.json?page=1&min=100&max=100000 みたいな
  def budget
    min = params[:min]
    max = params[:max]
    @products = Product.where('price >= ?',params[:min]).where('price <= ?',params[:max]).page(params[:page]).per(3).order("created_at DESC")
    @current_page = params[:page].to_i
  end

#TODO 予算別、シチュエーション別、ランキング、フリーワード

end
