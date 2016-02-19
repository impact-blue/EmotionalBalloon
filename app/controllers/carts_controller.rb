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
        binding.pry
    # WebPay上での顧客の情報を作成
    customer = webpay.customer.create(card: params['webpay-token'])
    @order = Order.find(16)
    # 顧客情報を使って支払い
    webpay.charge.create(
      amount: @order.price,
      currency: 'jpy',
      customer: customer.id
    )

    redirect_to action: 'thanks'
  rescue WebPay::ErrorResponse::CardError => e
    # エラーハンドリング。発生する例外の種類がいくつか用意されているので、内容に応じて処理を書く
  end


  def api
    ActiveRecord::Base.transaction do
      @order = Order.new(order_params)
      @order.price = 0

      params[:data][:product_info].each_with_index do |product_info,i|
        #商品の合計値段計算
        @order.price += Product.find(product_info[:id]).price
        #購入商品登録
        @order.order_product_infos.build
        @order.order_product_infos[i].product_id = product_info[:id]
      end
      @order.postal_code      = params[:data][:destination_info][:postal_code]
      @order.city             = params[:data][:destination_info][:prefectures]
      @order.delivery_address = params[:data][:destination_info][:address]
      @order.phone = params[:data][:destination_info][:phone]
      #@order.date
      @order.payment_info     = params[:data][:payment_info][:method]
      #カードの場合は入金済み
      @order.order_status     = "未入金"


      @order.user = User.new(user_params)
      @order.user.email       = params[:data][:buyer_info][:mail]
      @order.user.phone       = params[:data][:buyer_info][:phone]
      @order.user.postal_code = params[:data][:buyer_info][:postal_code]
      @order.user.city        = params[:data][:buyer_info][:prefectures]
      @order.user.address     = params[:data][:buyer_info][:address]

      #連名(User)
      params[:data][:buyer_info][:name].each_with_index do |name,i|
          @order.user.user_names.build
          @order.user.user_names[i].user_family_name = name[:family_name]
          @order.user.user_names[i].user_first_name  = name[:first_name]
      end
      #連名(Order)
      params[:data][:destination_info][:name].each_with_index do |name,i|
          @order.order_delivery_names.build
          @order.order_delivery_names[i].order_family_name = name[:family_name]
          @order.order_delivery_names[i].order_first_name  = name[:first_name]
      end
      #購入した商品のカウント
      params[:data][:product_info].each_with_index do |product_info,i|
          @product = Product.find(product_info[:id])
          @product.count += product_info[:count]
          @product.save!
      end

       #商品の在庫を減らすアクション

#エラーの内容を表示させる
      #トランザクションで全て保存のみに対応にする。
      if @order.save!
        render json: {data:{result:"success"}}
      end
    end
    rescue
      render json: {data:
                            {result:"error",
                             "message":
                              @order.errors.full_messages.each do |msg|
                                [
                                  "msg",
                                ]
                              end
                            }
                   }
    end

  def thanks
    @order = Order.find(3)

    #Mailer.buy_thanks_email(@order).deliver
  end

  private

  def user_params
    params = ActionController::Parameters.new(JSON.parse(request.body.read))
    params.require(:data).permit(:id,:number)
  end

  def user_name_params
    params = ActionController::Parameters.new(JSON.parse(request.body.read))
    params.require(:data).permit(:id)
  end

  def order_params
    params.require(:data).permit(:id,:phone,:postal_code,:city,:delivery_address,:order_status)
  end

  def order_product_params
    params = ActionController::Parameters.new(JSON.parse(request.body.read))
    params.require(:data).permit(:id)
  end

end
