class ColorsController < ApplicationController


def create
  @color = Color.new(create_params)
  if @color.save
    redirect_to  admin_balloon_options_path
  else
    redirect_to admin_balloon_options_path
  end
end

def edit
  @boxsize = Boxsize.find(params[:id])
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
  params.require(:color).permit(:color)
end

end
