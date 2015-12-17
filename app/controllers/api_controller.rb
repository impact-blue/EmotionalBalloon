class Api::ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
#TODO before_action
  def show
  @product = Product.all
  end


end
