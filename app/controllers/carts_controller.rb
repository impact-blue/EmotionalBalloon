class CartsController < ApplicationController

  def show
  end

  def register
  end

  def comfirm
    @user = User.new
  end

  def api
    @order = Order.new(order_params)
    @order.delivery_address = params[:data][:destination_info][:address1]
    @order.order_status = "新着"
    @order.payment_info = params[:data][:payment_info][:method]

    @order.user = User.new(user_params)
    @order.user.family_name = params[:data][:buyer_info][:family_name]
    @order.user.first_name = params[:data][:buyer_info][:first_name]
    @order.user.address = params[:data][:buyer_info][:address1]
    @order.user.address2 = params[:data][:buyer_info][:address2]
    @order.user.email = params[:data][:buyer_info][:mail]
    @order.user.phone = params[:data][:buyer_info][:phone]

    @order.price = 0
    params[:data][:product_info].each_with_index do |product_info,i|
      #商品の合計値段計算
      @order.price += Product.find(product_info[:id]).price
      #購入商品登録
      @order.order_product_infos.build
      @order.order_product_infos[i].product_id = product_info[:id]
    end

    if @order.save
      render json: {data:{result:"success"}}
    else
      redirect_to carts_thanks_path
   #  render json: {data:{result:"success"}}
    end
  end

  def thanks
    @order = Order.find(1)

    #Mailer.buy_thanks_email(@order).deliver
  end

  private

  def user_params
    params = ActionController::Parameters.new(JSON.parse(request.body.read))
    params.require(:data).permit(:id,:number)
  end

  def order_params
    params = ActionController::Parameters.new(JSON.parse(request.body.read))
    params.require(:data).permit(:id)
  end

  def order_product_params
    params = ActionController::Parameters.new(JSON.parse(request.body.read))
    params.require(:data).permit(:id)
  end

end
