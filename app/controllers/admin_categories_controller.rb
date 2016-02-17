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

  def scene_index

  end

  def chara_index
    @json_category_list = Chara.all
  end

  def edit

  end

  def create
  end

  def update
  end


  private

  def create_params
  end


end