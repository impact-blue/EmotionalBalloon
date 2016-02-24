class ProductsController < ApplicationController

  def index
    unless params[:filter].present?
      @json_products = Product.where(status: 1).page(params[:page]).per(20).order("created_at ASC")
    end
    #シーン検索
    if params[:scene] == "all"
      @json_products = Product.where(status: 1).page(params[:page]).per(20).order("created_at ASC")
    elsif params[:scene].present?
      @json_products =
        Product.where(status: 1).includes(:scenes)
          .merge(ProductScene.where(status: 1).order("product_id asc")
            .where(scene_id: Scene
              .find_by(
                  "name_en = ?" , params[:scene]
              )
            )
          ).references(:scene).page(params[:page]).per(20)
    end
    #キャラクター検索
    #キャラクターの綴りがおかしい。(all)
    if params[:caracter] == "all"
      @json_products = Product.where(status: 1).page(params[:page]).per(20).order("created_at ASC")
    elsif params[:character].present?
      @json_products =
        Product.where(status: 1).includes(:charas)
          .merge(ProductChara.where(status: 1).order("product_id asc")
            .where(chara_id: Chara
              .find_by(
                  "name_en = ?" , params[:character]
              )
            )
          ).references(:chara).page(params[:page]).per(20)
    end

    #予算別
    if params[:min].present? && params[:max].present?
      @json_products = Product.where(status: 1).where('price >= ? AND price <= ?',params[:min],params[:max]).page(params[:page]).per(@page).order("created_at ASC")
    elsif params[:max].present?
      @json_products = Product.where(status: 1).where('price <= ?',params[:max]).page(params[:page]).per(@page).order("created_at ASC")
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
    @json_detail_product = Product.includes(:scenes,:charas).find(params[:id])
  end

  def ranking
    @json_ranking_products = Product.all.page(params[:page]).per(5).order("count DESC")
  end



  private

  def cart_params
    params.require(:cart).permit(:product_id,:ip)
  end


end
