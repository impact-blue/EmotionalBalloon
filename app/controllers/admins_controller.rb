class AdminsController < ApplicationController

  def new
    @product = Product.new
  end

  def show
    unless logged_in?
      redirect_to admin_login_path
    end
    @product = Product.all
  end

  def create
    @product = Product.new(create_params)
    if @product.save
      redirect_to admin_show_path, notice: '商品の追加が完了しました。'
    else
      render action: 'show'
    end
  end

  private

  def create_params
    params.require(:product).permit(:product,:price,:stocks,:postage,:comment,:recommended,:keyword,:boxsize_id)
  end

end