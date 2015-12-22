class Mailer < ApplicationMailer
  default from: "negai.m.nishimura@gmail.com"
        #  cc: ""
  def send_email(order)
    @order = order
    mail to: order.user.email, subject:'購入商品のメール'
    #会社へのメールも設定する。
  end
end
