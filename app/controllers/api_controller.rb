class Api::ApiController < ApplicationController
#TODO before_action
  def api
  @product = Product.all
  end


end
