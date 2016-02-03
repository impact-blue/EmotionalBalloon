class AdminCategoryChildrenController < ApplicationController
  before_action :logged_in_admin_user

  def index
    @category_child = Category_child.where(category_id: params[:id])
  end

  def new
    @category = Category.find(params[:admin_category_id])
    @category_children = CategoryChild.where(category_id: params[:admin_category_id])
    @category_child = CategoryChild.new
  end

  def create
    @category_child = CategoryChild.new(create_params)
    @category_child.category_id = params[:admin_category_id]

    if @category_child.save
      redirect_to :back
    else
      render action: 'new'
    end
  end

  def update
    @category_child = Category_child.find(params[:id])
    if @category_child.update_attributes(create_params)
      flash[:success] = "編集しました"
      redirect_to admin_products_path, notice: '商品の編集が完了しました。'
    else
      render 'edit'
    end
  end

  private

  def create_params
    params.require(:category_child).permit(:name,:category_id)
  end

end