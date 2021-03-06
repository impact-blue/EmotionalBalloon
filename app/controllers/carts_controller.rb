class CartsController < ApplicationController

  def show
  end

  def register
  end

  def comfirm
    @user = User.new
  end

  def api
    begin
        ActiveRecord::Base.transaction do
          @order = Order.new(order_params)
          @order.price = 0
          params[:data][:product_info].each_with_index do |product_info,i|
            #購入商品登録
            @order.order_product_infos.build
            @order.order_product_infos[i].product_id = product_info[:id]
            @order.order_product_infos[i].count = product_info[:count]
            @order.order_product_infos[i].sum_price = (Product.select("price").find(product_info[:id]).price * product_info[:count]) #OrderProductInfoに合計値段を記述（管理画面で売上表示用）
            #商品の合計値段計算
            @order.price  += @order.order_product_infos[i].sum_price
          end
          @order.postal_code      = params[:data][:destination_info][:postal_code]
          @order.city             = params[:data][:destination_info][:prefectures]
          @order.delivery_address = params[:data][:destination_info][:address]
          @order.delivery_phone = params[:data][:destination_info][:phone]
          #@order.date
          @order.payment_info     = params[:data][:payment_info][:method]
          #カードの場合は入金済み
          @order.order_status     = "未入金"

          @order.user = User.new(user_params)
          @order.user.email       = params[:data][:buyer_info][:mail]
          @order.user.customer_phone       = params[:data][:buyer_info][:phone]
          @order.user.postal_code = params[:data][:buyer_info][:postal_code]
          @order.user.city        = params[:data][:buyer_info][:prefectures]
          @order.user.address     = params[:data][:buyer_info][:address]

          #連名(User)
          params[:data][:buyer_info][:name].each_with_index do |name,i|
              if i == 0 #リピート検索の時に使う情報
                @order.user.name = name[:family_name] + name[:first_name]
              end
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
              @product.stocks -= product_info[:count] #商品の在庫を減らすアクション。本当にここでいい？発送時？
              @product.save!
          end

          #リピートの検索
            repeat_user = User.repeat_search(@order)
            @order.user.repeat_count   = repeat_user[:repeat_count]
            unless repeat_user[:first_user_id] == "null"
              @order.user.repeat_user_id = repeat_user[:first_user_id]
              #リピートレコード全てを更新
              all_repeat_user = User.where(repeat_user_id: repeat_user[:first_user_id])
              all_repeat_user << User.find(repeat_user[:first_user_id]) #最初のリピートがnullのため
              all_repeat_user.each do |aru|
                aru.repeat_count   = repeat_user[:repeat_count]
                aru.repeat_user_id = repeat_user[:first_user_id]
                aru.save!
              end
            end
          #トランザクションで全て保存のみに対応にする。
          if @order.save!
            #webpayの処理
            if @order.payment_info == "credit"
                webpay = WebPay.new(WEBPAY_SECRET_KEY)
                webpay.set_accept_language('ja')
                #トークンの作成
                  token = webpay.token.create(
                      card:
                        { number: params[:data][:payment_info][:content][:number],
                          exp_month: params[:data][:payment_info][:content][:exp_month] ,
                          exp_year: params[:data][:payment_info][:content][:exp_year] ,
                          cvc: params[:data][:payment_info][:content][:cvc] ,
                          name: params[:data][:payment_info][:content][:name]}
                    ).id
                # WebPay上での顧客の情報を作成
                customer = webpay.customer.create(card: token)
                # API リクエスト
                webpay.charge.create(
                  amount: @order.price,
                  currency: 'jpy',
                  customer: customer.id
                )
            end
            render json: {data:{result:"success"}}
          end
        end
      rescue WebPay::ErrorResponse::ErrorResponseError => e

            case e.data.error.caused_by
                when 'buyer'
                  # カードエラーなど、購入者に原因がある
                  # エラーメッセージが購入者に分かりやすいものになっているので
                  # そのまま表示する
                  render json: {data:
                                        {result:"error",
                                         "message":
                                          e.data.error.message
                                        }
                               }
                  # 頻繁に発生し、サービス側で対応の必要がないので、ロギングは必須ではない
                  # サポート目的でロギングする場合はINFOレベル以下が良い

                when 'insufficient', 'missing'
                  # 実装ミスに起因する
                  # ERRORレベルでログに残し、すぐに対処する
                  error = e.data.error
                  log(ERROR, "Invalid request error: message:#{error.message} " +
                      "caused_by:#{error.caused_by} " +
                      "param:#{error.param} " +
                      "type:#{error.type}")

                  # 詳細を購入者に告知する必要はないので、固定のメッセージを表示する
                  render json: {data:
                                        {result:"error",
                                         "message":
                                          'サービスの障害により、現在ご利用いただけません。'
                                        }
                               }

                  # 大抵の場合 insufficient と missing は同様に扱えるが
                  # 運用上 missing の発生を避けられない場合は個別に対処する

                when 'service'
                  # WebPayに起因するエラー
                  log(ERROR, "WebPay API error: message:#{e.data.error.message}")
                  render json: {data:
                                        {result:"error",
                                         "message":
                                          'サービスの障害により、一時的にご利用いただけません。" +
                      "少し時間をおいて再度お試しください。'
                                        }
                               }
                else
                  # 未知のエラー
                  # 新しいエラーの原因が追加されたが、対応していない場合などが想定される
                  error = e.data.error
                  log(ERROR, "Unknown error response: message:#{error.message} " +
                      "caused_by:#{error.caused_by} " +
                      "type:#{error.type}")

                  # 原因が予測できないので固定のメッセージにする
                  render json: {data:
                                        {result:"error",
                                         "message":
                                          'サービスの障害により、現在ご利用いただけません。'
                                        }
                               }
                return
            end
      rescue WebPay::ApiError => e
                # APIからのレスポンスが受け取れない場合。接続エラーなど
                log(ERROR, "API request is not completed: #{e}")
                render json: {data:
                                        {result:"error",
                                         "message":
                                          'サービスの障害により、現在ご利用いただけません。'
                                        }
                               }
          return
      rescue
          render json: {data:
                                {result:"error",
                                 "message":
                                    @order.errors.full_messages.each do |msg|
                                      ["msg",]
                                    end
                                }
                       }
    end
  end

  def thanks
    #@order = Order.find(3)
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
    params.require(:data).permit(:id,:delivery_phone,:postal_code,:city,:delivery_address,:order_status)
  end

  def order_product_params
    params = ActionController::Parameters.new(JSON.parse(request.body.read))
    params.require(:data).permit(:id)
  end

end