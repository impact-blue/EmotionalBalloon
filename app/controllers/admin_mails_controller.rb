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

  def api
    @mail         = MailContent.find(params[:data][:id])
    @mail.subject = params[:data][:subject]
    @mail.text    = params[:data][:content]
    if @mail.save
      render json: {data:{result:"success"}}
    else
      render json: {data:{result:"false"}}
    end
  end

  private

  def mail_params
    params.require(:mail_content).permit(:subject,:text)
  end



end
