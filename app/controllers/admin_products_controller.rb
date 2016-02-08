class AdminProductsController < ApplicationController
  before_action :logged_in_admin_user
  before_action :set_json_index

  def new
    @product = Product.new
  end


  def index
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

    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: "products-#{Time.now.to_date.to_s}.csv", type: :csv
      end
    end
  end

  def show
    @product = Product.all.includes(:balloon_types,:colors,:charas,:scenes,:boxsize)
  end

  def edit
    @product = Product.find(params[:id])
    @json_detail_product = Product.find(params[:id])
  end

  def create
    @product = Product.new(create_params)
    if @product.save
      redirect_to admin_products_path, notice: '商品の追加が完了しました。'
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
    if params[:id].nil?
      @product = Product.new(product_params)
      @product.count = 0
    elsif params[:id].present?
      @product = Product.find(params[:id])
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
   # @product.user = User.new(user_params)
    #@product.user.first_name = params[:data][:buyer_info][:family_name]

    params[:data][:images].each_with_index do |product_info,i|
      @product.images.build
      @product.images[i].product_id = @product.id
      @product.images[i].image = params[:data][:images][i]
    end

    #params[:data][:scene].each_with_index do |product_info,i|
    #  @product.scenes.build
    #  @product.scenes[i].product_id = @product.id
    #  @product.scenes[i].image = params[:data][:images][i]
    #end

    if @product.save
      render json: {data:{result:"success"}}
    end
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
