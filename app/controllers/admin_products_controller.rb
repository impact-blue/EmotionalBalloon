class AdminProductsController < ApplicationController
  before_action :logged_in_admin_user
  before_action :set_json_index

  def new
    @product = Product.new
  end


  def index
    #全商品個数の表示
    #@product_count = Product.count

    unless params[:filter].present?
      redirect_to "/admin/products?filter=all"
    end

    if params[:filter] == "all"
      @json_products = Product.all.page(params[:page]).per(@page).order("created_at ASC")
    elsif params[:filter] == "public"
      @json_products = Product.where(status: 1).page(params[:page]).per(@page).order("created_at ASC")
    elsif params[:filter] == "secret"
      @json_products = Product.where(status: 0).page(params[:page]).per(@page).order("created_at ASC")
    elsif params[:filter] == "none"
      @json_products = Product.where(stocks: 0).page(params[:page]).per(@page).order("created_at ASC")
    end

    #CSVダウンロード
    #<a href="/admin/products.csv/?filter=all&page={{data.search_products.current_page}}">CSV</a>
    respond_to do |format|
      format.html and return
      format.csv do
        send_data render_to_string, filename: "products-#{Time.now.to_date.to_s}.csv", type: :csv
      end
    end
  end

  def edit
    @json_detail_product = Product.includes(:charas,:scenes).find(params[:id])
    @json_scene_list = Scene.all
    @json_chara_list = Chara.all
  end

  def create
    @product = Product.new(create_params)
    if @product.save
      redirect_to "/admin/products?filter=all" , notice: '商品の追加が完了しました。'
    else
      render action: 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(create_params)
      flash[:success] = "編集しました"
      redirect_to admin_products_path, notice: '商品の編集が完了しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end

  def api
    if params[:data][:id].nil?
      @product = Product.new(product_params)
      @product.count = 0
    elsif params[:data][:id].present?
      @product = Product.find(params[:data][:id])
     # @json_detail_product = Product.find(params[:id])
    end

    @product.name = params[:data][:name]
    @product.price = params[:data][:price]
    @product.stocks = params[:data][:stock]
    @product.main_image = params[:data][:images][0]
    @product.comment = params[:data][:description]
    @product.size = params[:data][:size]

    if params[:data][:status] = "true"
      @product.status = 1
    elsif parama[:data][:status] = "false"
      @product.status = 0
    end

    if params[:data][:images].present?
      params[:data][:images].each_with_index do |product_info,i|
        @product.images.build
        @product.images[i].product_id = @product.id
        @product.images[i].image = params[:data][:images][i]
      end
    end

    if params[:data][:scenes].present?
      params[:data][:scenes].each_with_index do |product_info,i|
        @product.product_scenes.build
        @product.product_scenes[i].product_id = @product.id
        @product.product_scenes[i].scene_id = Scene.find_by(name_en: product_info).id
      end
    end

    if params[:data][:characters].present?
      params[:data][:characters].each_with_index do |product_info,i|
        @product.product_charas.build
        @product.product_charas[i].product_id = @product.id
        @product.product_charas[i].chara_id = Chara.find_by(name_en: product_info).id
      end
    end

    if params[:data][:color].present?
      params[:data][:colors].each_with_index do |product_info,i|
        @product.product_colors.build
        @product.product_colors[i].product_id = @product.id
        @product.product_colors[i].color_id = Color.find_by(name_en: product_info).id
      end
    end

    #保存
    if @product.save
      render json: {data:{result:"success"}}
    else
      render json: {data:{result:"false"}}
    end
  end

  def import
    Product.import(params[:file])
    redirect_to "/admin/products?filter=all"
  end

  private

  def create_params
    params.require(:product).permit(:name,:price,:stocks,:comment,:recommended,:keyword,:boxsize_id,:registration_date,{:scene_ids =>[]},{:color_ids =>[]},{:chara_ids =>[]},{:balloon_type_ids =>[]})
  end

  def product_params
    params = ActionController::Parameters.new(JSON.parse(request.body.read))
    params.require(:data).permit(:id)
  end

end
