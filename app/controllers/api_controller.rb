class ApiController < ApplicationController
#TODO before_action
  def show
  @product = Product.all
  end


end
