class UsersController < ApplicationController

  def create
    @user = User.new(create_params)
  end

  def new
    @user = User.new
  end

  private
  def create_paramss
  params.require(:user).permit(:first_name,:first_name_kana,:last_name,:last_name_kana,:email,:phone,:postal_code,:address,:address2)
  end

end
