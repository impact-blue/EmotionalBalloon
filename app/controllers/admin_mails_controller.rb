class AdminMailsController < ApplicationController
before_action :logged_in_admin_user

  def edit
    if params[:template] == "card"
      @json_detail_mail = MailContent.find(1)
    elsif params[:template] == "bank"
      @json_detail_mail = MailContent.find(2)
    elsif params[:template] == "cod"
      @json_detail_mail = MailContent.find(3)
    elsif params[:template] == "contact"
      @json_detail_mail = MailContent.find(4)
    end
  end

  def update
    if @card_mail_content.update_attributes(mail_params)
      redirect_to '/admin'
    else
      render 'mail_setting'
    end
  end

  private

  def mail_params
    params.require(:mail_content).permit(:subject,:text)
  end



end
