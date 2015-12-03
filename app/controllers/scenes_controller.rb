class ScenesController < ApplicationController


def create
  @scene = Scene.new(create_params)
  if @scene.save
    redirect_to  admin_balloon_options_path
  else
    redirect_to admin_balloon_options_path
  end
end

private

def create_params
  params.require(:scene).permit(:scene)
end

end
