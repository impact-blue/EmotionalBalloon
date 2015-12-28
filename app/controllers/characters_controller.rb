class CharactersController < ApplicationController
  layout 'admin_header'
  def create
    @chara = Chara.new(create_params)
    if @chara.save
      redirect_to  admin_balloon_options_path
    else
      redirect_to admin_balloon_options_path
    end
  end

  def edit
    @chara = Chara.find(params[:id])
  end

  def update
    @chara = Chara.find(params[:id])
    if @chara.update_attributes(create_params)
      flash[:success] = "編集しました"
      redirect_to admin_balloon_options_path, notice: '商品の編集が完了しました。'
    else
      render 'index'
    end
  end

  private

  def create_params
    params.require(:chara).permit(:chara,:id)
  end

end
