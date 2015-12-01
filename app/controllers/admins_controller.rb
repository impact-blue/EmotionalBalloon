class AdminsController < ApplicationController

  def show
    unless logged_in?
      redirect_to admin_login_path
    end
  end


end
