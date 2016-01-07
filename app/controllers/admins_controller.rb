class AdminsController < ApplicationController
  before_action :logged_in_admin_user
  layout 'header_admin'

  def new
    @product = Product.new
  end

  def show
    @product = Product.all
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(create_params)
    @product.number = 0
    if @product.save
      redirect_to admin_show_path, notice: '商品の追加が完了しました。'
    else
      render action: 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(create_params)
      flash[:success] = "編集しました"
      redirect_to admin_show_path, notice: '商品の編集が完了しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_show_path
  end

  private

  def create_params
    params.require(:product).permit(:name,:price,:stocks,:comment,:recommended,:keyword,:boxsize_id,:registration_date,{:scene_ids =>[]},{:color_ids =>[]},{:chara_ids =>[]},{:balloon_type_ids =>[]})
  end

  def logged_in_admin_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to admin_login_path
    end
  end

end