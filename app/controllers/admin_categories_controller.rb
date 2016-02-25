class AdminCategoriesController < ApplicationController
  before_action :logged_in_admin_user

  def index
    if params[:filter] == "all"
      @json_category_list = Scene.all + Chara.all
    elsif params[:filter] == "scene"
      @json_category_list = Scene.all
    elsif params[:filter] == "character"
      @json_category_list = Chara.all
    end
  end


  def chara_index
    @json_category_list = Chara.all
  end

  def create
  end

  def edit
    if request.path.include?("scene")
      @json_category_detail = Scene.find(params[:id])
    elsif request.path.include?("chara")
      @json_category_detail = Chara.find(params[:id])
    end
  end

  def api

    @category = Scene.new(create_params)
    @category.name_en = params[:data][:category_detail][:name_en]
    @category.name_ja = params[:data][:category_detail][:name_jp]

    if  @category.save
      render json: {data:{result:"success"}}
    else
      render json: {data:{result:"false"}}
    end
  end


  private

  def create_params
    params.permit(:name_en,:name_ja)
  end


end