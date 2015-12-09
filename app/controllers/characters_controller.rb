class CharactersController < ApplicationController
  layout 'admin_header'
  def create
    @character = Character.new(create_params)
    if @character.save
      redirect_to  admin_balloon_options_path
    else
      redirect_to admin_balloon_options_path
    end
  end

  def edit
    @character = Character.find(params[:id])
  end

  def update
    @character = Character.find(params[:id])
    if @character.update_attributes(create_params)
      flash[:success] = "編集しました"
      redirect_to admin_balloon_options_path, notice: '商品の編集が完了しました。'
    else
      render 'index'
    end
  end

  private

  def create_params
    params.require(:character).permit(:character,:id)
  end

end
