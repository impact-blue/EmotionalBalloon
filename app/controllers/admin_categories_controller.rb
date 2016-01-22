class AdminCategoriesController < ApplicationController
  before_action :logged_in_admin_user

  def index
    @category = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(create_params)

    if @category.save
      redirect_to admin_categories_path
    else
      render action: 'new'
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(create_params)
      flash[:success] = "編集しました"
      redirect_to admin_products_path, notice: '商品の編集が完了しました。'
    else
      render 'edit'
    end
  end

  private

  def create_params
    params.require(:category).permit(:name)
  end

  def logged_in_admin_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to admin_login_path
    end
  end

end