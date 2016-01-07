class ApiController < ApplicationController
#TODO before_action
#出力例http://localhost:3000/api/product/search.json?page=2&min=100&max2000
  def apis_product_search
    min = params[:min]
    max = params[:max]
    price = params[:price]
    scene = params[:scene]
    chara = params[:chara]
    color = params[:color]
    balloon_type = params[:balloon_type]
    @page = 3

    if min.present? && max.present?
      @products = Product.where('price >= ? AND price <= ?',params[:min],params[:max]).page(params[:page]).per(@page).order("created_at DESC")
      @current_page = params[:page].to_i

#単一検索
    elsif min.present? #最小価格
      @products = Product.where('price >= ? ',params[:min]).page(params[:page]).per(@page).order("created_at DESC")
      @current_page = params[:page].to_i
    elsif max.present? #最大価格
      @products = Product.where('price <= ? ',params[:max]).page(params[:page]).per(@page).order("created_at DESC")
      @current_page = params[:page].to_i
    elsif scene.present? #シーン別
      @products = Kaminari.paginate_array(Product.includes(:scenes).where('scene = ?', params[:scene]).references(:scene).order("products.created_at DESC")).page(params[:page]).per(@page)
      @current_page = params[:page].to_i

    elsif chara.present? #キャラクター別
      @products = Kaminari.paginate_array(Product.includes(:charas).where('chara = ?', params[:chara]).references(:chara).order("products.created_at DESC")).page(params[:page]).per(@page)
      @current_page = params[:page].to_i

    elsif color.present? #色別
      @products = Kaminari.paginate_array(Product.includes(:colors).where('color = ?', params[:color]).references(:color).order("products.created_at DESC")).page(params[:page]).per(@page)
      @current_page = params[:page].to_i
    elsif balloon_type.present? #バルーンタイプ別
      @products = Kaminari.paginate_array(Product.includes(:balloon_types).where('balloon_type = ?', params[:balloon_type]).references(:balloon_type).order("products.created_at DESC")).page(params[:page]).per(@page)
      @current_page = params[:page].to_i
#条件なし
    else
      @products = Product.page(params[:page]).per(@page).order("created_at DESC")
      @current_page = params[:page].to_i
    end
#終了
  end

  def ranking
    @page = 5
    @products = Product.page(params[:page]).per(@page).order("number DESC")
    @current_page = params[:page].to_i
  end
#http://localhost:3000/api/budget.json?page=1&min=100&max=100000 みたいな
  def budget
    min = params[:min]
    max = params[:max]
    @products = Product.where('price >= ?',params[:min]).where('price <= ?',params[:max]).page(params[:page]).per(@page).order("created_at DESC")
    @current_page = params[:page].to_i
  end

  def detail
    @product = Product.find(params[:id])
    #http://localhost:3000/api/detail.json?id=2
  end

#TODO 予算別、シチュエーション別、ランキング、フリーワード

end
