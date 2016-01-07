class BalloonTypesController < ApplicationController
  layout 'header_admin'
   def create
    @balloon_type = BalloonType.new(create_params)
    if @balloon_type.save
      redirect_to  admin_balloon_options_path
    else
      redirect_to admin_balloon_options_path
    end
  end

  def edit
    @balloon_type = BalloonType.find(params[:id])
  end

  def update
    @balloon_type = BalloonType.find(params[:id])
    if @balloon_type.update_attributes(create_params)
      flash[:success] = "編集しました"
      redirect_to admin_balloon_options_path, notice: '商品の編集が完了しました。'
    else
      render 'index'
    end
  end

  private

  def create_params
    params.require(:balloon_type).permit(:balloon_type,:id)
  end

end
