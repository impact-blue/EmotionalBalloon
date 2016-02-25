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
      @type =  "scene"
    elsif request.path.include?("chara")
      @json_category_detail = Chara.find(params[:id])
      @type = "character"
    end
  end

  def api_scene
    if params[:data][:id].present?
      @category = Scene.find(params[:data][:id])
    elsif prams[:data][:id].nil?
      @category = Scene.new(create_params)
    end

    @category.name_en = params[:data][:name_en]
    @category.name_ja = params[:data][:name_jp]

    if  @category.save
      render json: {data:{result:"success"}}
    else
      render json: {data:{result:"false"}}
    end
  end

  def api_chara
    if params[:data][:id].present?
      @category = Scene.find(params[:data][:id])
    elsif prams[:data][:id].nil?
      @category = Scene.new(create_params)
    end

    @category.name_en = params[:data][:name_en]
    @category.name_ja = params[:data][:name_jp]

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