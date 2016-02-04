class AdminProductsController < ApplicationController
  before_action :logged_in_admin_user
  before_action :set_json_index

  def new
    @product = Product.new
  end

  def index
    @products = Product.all
    @product_count = Product.count

    if params[:filter] == "all"
      @json_products = Product.all.page(params[:page]).per(@page).order("created_at DESC")
    elsif params[:filter] == "public"
      @json_products = Product.where(status: 1).page(params[:page]).per(@page).order("created_at DESC")
    elsif params[:filter] == "secret"
      @json_products = Product.where(status: 0).page(params[:page]).per(@page).order("created_at DESC")
    elsif params[:filter] == "none"
      @json_products = Product.where(stocks: 0).page(params[:page]).per(@page).order("created_at DESC")
    end
  end

  def show
    @product = Product.all.includes(:balloon_types,:colors,:charas,:scenes,:boxsize)
  end

  def edit
    @product = Product.find(params[:id])
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

  private

  def create_params
    params.require(:product).permit(:name,:price,:stocks,:comment,:recommended,:keyword,:boxsize_id,:registration_date,{:scene_ids =>[]},{:color_ids =>[]},{:chara_ids =>[]},{:balloon_type_ids =>[]})
  end


end
