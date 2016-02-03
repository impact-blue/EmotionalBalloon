class CartsController < ApplicationController

  def show
  end

  def register
  end

  def comfirm
    @user = User.new
  end

  def api
    @user = User.new(user_params)
    @user.first_name = params[:data][:buyer_info][:family_name]
    @user.last_name = params[:data][:buyer_info][:first_name]
    @user.address = params[:data][:buyer_info][:address1]
    @user.address2 = params[:data][:buyer_info][:address2]
    @user.email = params[:data][:buyer_info][:mail]
    @user.phone = params[:data][:buyer_info][:phone]

    @user.order = Order.new(order_params)
    @user.order.delivery_address = params[:data][:destination_info][:address1]

    if @user.save
      render json: {data:{result:"success"}}
    else
      redirect_to carts_thanks_path
   #    render json: {data:{result:"success"}}
    end
  end

  def thanks
  end

  private

  def user_params
    params = ActionController::Parameters.new(JSON.parse(request.body.read))
    params.require(:data).permit(:id,:number)
  end

  def order_params
    arams = ActionController::Parameters.new(JSON.parse(request.body.read))
    params.require(:data).permit(:id)
  end

end
