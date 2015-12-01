class AdminsController < ApplicationController

  def show
    unless logged_in?
      redirect_to admin_login_path
    end
    @product = Product.all
  end

  def create
    @product = Product.new(create_params)
  end

  private

  def create_params
    params.require(:product).permit(:content,:user_id,:room_id)
  end


end