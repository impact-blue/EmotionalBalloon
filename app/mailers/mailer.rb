class Mailer < ApplicationMailer
  default from: "negai.m.nishimura@gmail.com"
        #  cc: ""
  def buy_thanks_email(order)
    @mail_content = MailContent.find(1)
    @order = order
    mail to: order.user.email, subject: @mail_content.subject
    #会社へのメールも設定する。
  end

end
