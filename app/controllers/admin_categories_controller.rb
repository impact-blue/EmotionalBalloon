class AdminCategoriesController < ApplicationController
  before_action :logged_in_admin_user

  def index
    unless params[:filter].present?
      redirect_to "/admin/categories?filter=all"
    end
    if params[:filter] == "all"
      @json_category_list = Category.all
      @json_scene_list = @json_category_list.where(genre: :scene)
      @json_chara_list = @json_category_list.where(genre: :character)
    elsif params[:filter] == "scene"
      @json_category_list = Category.all
      @json_scene_list = Category.where(genre: :scene)
    elsif params[:filter] == "character"
      @json_category_list = Category.all
      @json_character_list = Category.where(genre: :character)
    end
  end


  def chara_index
    @json_category_list = Chara.all
  end

  def new
  end

  def edit
        @json_category_detail = Category.find(params[:id])
  end

  def api_scene
    if params[:data][:id].present?
      @category = Scene.find(params[:data][:id])
    elsif params[:data][:id].blank?
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
      @category = Chara.find(params[:data][:id])
    elsif params[:data][:id].blank?
      @category = Chara.new(create_params)
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