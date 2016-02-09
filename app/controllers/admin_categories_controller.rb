class AdminCategoriesController < ApplicationController
  before_action :logged_in_admin_user

  def index
    if params[:filter] == "all"
      @json_category_list = Scene.all + Chara.all
    elsif params[:filter] == "scene"
      @json_category_list = Scene.all
    elsif params[:filter] == "chara"
      @json_category_list = Chara.all
    end
  end

  def scene_index

  end

  def chara_index
    @json_category_list = Chara.all
  end

  def edit
    @boxsize = Boxsize.find(params[:id])
  end

  def create
    @boxsize = Boxsize.new(create_params)
    if @boxsize.save
      redirect_to  admin_balloon_options_path
    else
      render admin_balloon_options_path
    end
  end

  def update
    @boxsize = Boxsize.find(params[:id])
    if @boxsize.update_attributes(create_params)
      flash[:success] = "編集しました"
      redirect_to admin_balloon_options_path, notice: '商品の編集が完了しました。'
    else
      render 'index'
    end
  end


  private

  def create_params
    params.require(:boxsize).permit(:id,:boxsize)
  end


end