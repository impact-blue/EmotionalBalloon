class BalloontypesController < ApplicationController
  layout 'admin_header'
   def create
    @balloontype = Balloontype.new(create_params)
    if @balloontype.save
      redirect_to  admin_balloon_options_path
    else
      redirect_to admin_balloon_options_path
    end
  end

  def edit
    @balloontype = Balloontype.find(params[:id])
  end

  def update
    @balloontype = Balloontype.find(params[:id])
    if @balloontype.update_attributes(create_params)
      flash[:success] = "編集しました"
      redirect_to admin_balloon_options_path, notice: '商品の編集が完了しました。'
    else
      render 'index'
    end
  end

  private

  def create_params
    params.require(:balloontype).permit(:balloontype,:id)
  end

end
