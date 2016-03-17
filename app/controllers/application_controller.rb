class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

#  rescue_from Exception, with: :error500
#  rescue_from ActiveRecord::RecordNotFound, ActionController::RoutingError, with: :error404

  before_filter :basic

#rails s -b 153.120/168.115
  include SessionsHelper

  #商品詳細ページ、発送ページ、利用規約、下層
  def set_request_filter
   Thread.current[:request] = request
  end




  #def error404
  #  render 'error404', status: 404, formats: [:html]
  #end

  #def error500(e)
  #  logger.error [e, *e.backtrace].join("\n")
  #  render 'error500', status: 500, formats: [:html]
  #end


  private
    def basic
      authenticate_or_request_with_http_basic do |user, pass|
        user == 'balloon' && pass == '1234'
      end
    end

  def logged_in_admin_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to admin_login_path
    end
  end


  def set_json_categories
    @json_category_list = Category.all
  end

  def set_json_index
#    min = params[:min]
#    max = params[:max]
#    price = params[:price]
#    scene = params[:scene]
#    chara = params[:chara]
#    color = params[:color]
#    balloon_type = params[:balloon_type]
    @page = 20
    @per =20
    @current_page = params[:page].to_i

#    if min.present? && max.present?
#      @json_products = Product.where('price >= ? AND price <= ?',params[:min],params[:max]).page(params[:page]).per(@page).order("created_at DESC")
#      @current_page = params[:page].to_i

#単一検索
#    elsif min.present? #最小価格
#      @json_products = Product.where('price >= ? ',params[:min]).page(params[:page]).per(@page).order("created_at DESC")
#      @current_page = params[:page].to_i
#    elsif max.present? #最大価格
#      @json_products = Product.where('price <= ? ',params[:max]).page(params[:page]).per(@page).order("created_at DESC")
#      @current_page = params[:page].to_i
#    elsif scene.present? #シーン別
#      @json_products = Kaminari.paginate_array(Product.includes(:scenes).where('scene = ?', params[:scene]).references(:scene).order("products.created_at DESC")).page(params[:page]).per(@page)
#      @current_page = params[:page].to_i

#    elsif chara.present? #キャラクター別
#      @json_products = Kaminari.paginate_array(Product.includes(:charas).where('chara = ?', params[:chara]).references(:chara).order("products.created_at DESC")).page(params[:page]).per(@page)
#      @current_page = params[:page].to_i

#    elsif color.present? #色別
#      @json_products = Kaminari.paginate_array(Product.includes(:colors).where('color = ?', params[:color]).references(:color).order("products.created_at DESC")).page(params[:page]).per(@page)
#      @current_page = params[:page].to_i
#    elsif balloon_type.present? #バルーンタイプ別
#      @json_products = Kaminari.paginate_array(Product.includes(:balloon_types).where('balloon_type = ?', params[:balloon_type]).references(:balloon_type).order("products.created_at DESC")).page(params[:page]).per(@page)
#      @current_page = params[:page].to_i
#条件なし
#    else
#      @json_products = Product.page(params[:page]).per(@page).order("created_at DESC")
#      @current_page = params[:page].to_i
#    end
  end

end