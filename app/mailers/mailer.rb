class Mailer < ApplicationMailer
  default from: "negai.m.nishimura@gmail.com"
        #  cc: ""
  def card_buy_thanks_email(order)
    @mail_content = MailContent.find(1)
    @order = order
    mail to: order.user.email, subject: @mail_content.subject
    #会社へのメールも設定する。
  end

  def bank_buy_thanks_email(order)
    @mail_content = MailContent.find(2)
    @order = order
    mail to: order.user.email, subject: @mail_content.subject
  end

  def thanks_contact(contact)
    #api（メッセージ送信）のコントローラーでサンクスメッセージの送信（保存した後で、リダイレクトする前）
    @mail_content = MailContent.find(1)
    @contact = contact
    mail to: order.user.email, subject: @mail_content.subject
    @text =
      @mail_content.text
        .gsub(/\$name+/,@contact.name)
        .gsub(/\$email+/,@contact.email)
        .gsub(/\$subject+/,@contact.subject)
        .gsub(/\$content+/,@contact.content)
  end


end
