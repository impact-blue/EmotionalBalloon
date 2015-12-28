class ScenesController < ApplicationController
  layout 'header_admin'

def create
  @scene = Scene.new(create_params)
  if @scene.save
    redirect_to  admin_balloon_options_path
  else
    redirect_to admin_balloon_options_path
  end
end

def edit
  @scene = Scene.find(params[:id])
end

  def update
    @scene = Scene.find(params[:id])
    if @scene.update_attributes(create_params)
      flash[:success] = "編集しました"
      redirect_to admin_balloon_options_path, notice: '商品の編集が完了しました。'
    else
      render 'index'
    end
  end

private

def create_params
  params.require(:scene).permit(:id, :scene)
end

end
