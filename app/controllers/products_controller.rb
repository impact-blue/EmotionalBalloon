class ProductsController < ApplicationController
  before_action :set_json_categories,:set_json_index

  def index
    @category_name = Category.where(status: 1).pluck(:name_en)
    #シーン検索
    if request.path.include?("scenes")
        if request.path.include?("all")
          @json_products = []

          category_id = Category.where(["genre = ? and status = ?","scene","1"]).pluck(:id)
          category_id.each do |i|
             @json_products <<  Product.where("status = ? and category_id = ?",1, i )
          end

          @json_products =  @json_products.flatten.sort!{ |a, b| a[:id] <=> b[:id] }
          @json_products = Kaminari.paginate_array(@json_products).page(params[:page]).per(20)
          return
        end
      @category_name.each do |category_name|
        if request.path.include?("scenes/#{category_name}")
          @json_products =
            Product.where(category_id:  Category.find_by(["genre = ? and name_en = ?","scene",category_name]).id).page(params[:page]).per(20).order("created_at ASC")
          return
        end
      end
    end
    #キャラクター
    if request.path.include?("characters")
        if request.path.include?("all")
          @json_products = []
          category_id = Category.where(["genre = ? and status = ?","character","1"]).pluck(:id)
          category_id.each do |i|
             @json_products <<  Product.where("status = ? and category_id = ?",1, i )
          end

          @json_products =  @json_products.flatten.sort!{ |a, b| a[:id] <=> b[:id] }
          @json_products = Kaminari.paginate_array(@json_products).page(params[:page]).per(20)
          return
        end
      @category_name.each do |category_name|
        if request.path.include?("characters/#{category_name}")
          @json_products =
            Product.where(category_id:  Category.find_by(["genre = ? and name_en = ?","character",category_name]).id).page(params[:page]).per(20).order("created_at ASC")
          return
        end
      end
    end

    #予算別
    if params[:min].present? && params[:max].present?
      @json_products = Product.where(status: 1).where('price >= ? AND price <= ?',params[:min],params[:max]).page(params[:page]).per(@page).order("created_at ASC")
    elsif params[:max].present?
      @json_products = Product.where(status: 1).where('price <= ?',params[:max]).page(params[:page]).per(@page).order("created_at ASC")
    elsif params[:min].present?
      @json_products = Product.where(status: 1).where('price >= ?',params[:min]).page(params[:page]).per(@page).order("created_at ASC")
    end

  #以下は旧仕様
    #if min.present? && max.present?
    #  @products = Product.where('price >= ? AND price <= ?',params[:min],params[:max]).page(params[:page]).per(@page).order("created_at DESC")
    #  @current_page = params[:page].to_i

    #単一検索
    #elsif min.present? #最小価格
    #  @products = Product.where('price >= ? ',params[:min]).page(params[:page]).per(@page).order("created_at DESC")
    #  @current_page = params[:page].to_i
    #elsif max.present? #最大価格
    #  @products = Product.where('price <= ? ',params[:max]).page(params[:page]).per(@page).order("created_at DESC")
    #  @current_page = params[:page].to_i
    #elsif scene.present? #シーン別
    #  @products = Kaminari.paginate_array(Product.includes(:scenes).where('name_en = ?', params[:name_en]).references(:scene).order("products.created_at DESC")).page(params[:page]).per(@page)
    #  @current_page = params[:page].to_i

    #elsif chara.present? #キャラクター別
    #  @products = Kaminari.paginate_array(Product.includes(:charas).where('name_en = ?', params[:name_en]).references(:chara).order("products.created_at DESC")).page(params[:page]).per(@page)
    #  @current_page = params[:page].to_i

    #elsif color.present? #色別
    #  @products = Kaminari.paginate_array(Product.includes(:colors).where('color = ?', params[:color]).references(:color).order("products.created_at DESC")).page(params[:page]).per(@page)
    #  @current_page = params[:page].to_i
    #条件なし
    #else
    #  @products = Product.page(params[:page]).per(@page).order("created_at DESC")
    #  @current_page = params[:page].to_i
    #end
  #ここまで
  end

  def show
    @json_detail_product = Product.find(params[:id])
  end

  #月間のカウントの21個
  def ranking
    #カウント処理はバッジに追加

    #タイムゾーン取得
    current_day = Time.zone.now

    #30日間に購入された商品情報を取得
    last_30days_buy = OrderProductInfo.where('created_at >= ? ',Time.zone.now - 30.day).includes(:product)
    count_product = Hash.new(:id => 0,:count => 0)

    last_30days_buy.each do |p|
        count_product
    end

    @json_ranking_products = Product.all.page(params[:page]).per(5).order("count DESC")
  end

end
