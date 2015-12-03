class CharactersController < ApplicationController

def edit
end

def create
  @character = Character.new(create_params)
  if @character.save
    redirect_to  admin_balloon_options_path
  else
    redirect_to admin_balloon_options_path
  end
end

private

def create_params
  params.require(:character).permit(:character)
end

end
