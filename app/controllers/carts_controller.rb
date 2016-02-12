require "webpay"

class CartsController < ApplicationController

  def show
  end

  def register
  end

  def comfirm
    @user = User.new
  end

  def purchase
    webpay = WebPay.new(WEBPAY_SECRET_KEY)

    # WebPay上での顧客の情報を作成
    customer = webpay.customer.create(card: params['webpay-token'])

    # 顧客情報を使って支払い
    webpay.charge.create(
      amount: 10000,
      currency: 'jpy',
      customer: customer.id
    )
    @order = Order.new
    @order.user = User.new
    @order.payment_info = customer.id
    @order.save
    binding.pry
    redirect_to action: 'thanks'
  rescue WebPay::ErrorResponse::CardError => e
    # エラーハンドリング。発生する例外の種類がいくつか用意されているので、内容に応じて処理を書く
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
      params[:data][:product_info].each_with_index do |product_info,i|
        @product = Product.find(product_info[:id])
        @product.count += params[:data][:product_info][i][:count]
        @product.save
      end
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
