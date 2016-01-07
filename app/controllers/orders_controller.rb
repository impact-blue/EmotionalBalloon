class OrdersController < ApplicationController
#確認ページを作る。
  def new
    @order = Order.new
    @order.user = User.new
  end

  def create
    @order = Order.new(create_params)
    @order.user = User.new(user_model_params)
    if  @order.present? && @order.user.present?

          if @order.user.save && @order.save

                @product = Product.where(id: @order.product_id).each  do |product|
                  product.number += 1
                  product.save
                end
            #メールの送信      Mailer.send_email(@order).deliver
            redirect_to order_complete_path
          else
            render action: 'new'
          end
    else
      render action: 'new'
    end
  end

  def complete
  end

  private
  #productとorderの中間テーブルを作り、アソシエーションをかけ、配列で複数のプロダクトを受け取れるようにす
  def create_params
    params.require(:order).permit(
      :product_id,
      :user_id,
      :city_id,
      :order_status,
      :order_date,
      :delively_date,
      :delivery_address,
      :delivery_address2,
      :option,
      :phone,
      :scene_id,
      :opponent
      )
  end

  def user_model_params
  params.require(:user).permit(:first_name,:first_name_kana,:last_name,:last_name_kana,:email,:phone,:postal_code,:address,:address2,:city_id,:email_confirmation)
  end

end
