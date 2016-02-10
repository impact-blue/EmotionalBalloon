class AdminSettingsController < ApplicationController
  before_action :logged_in_admin_user
  def index
  end

  def mail_setting
    @mail_content = MailContent.find(1)
  end

  def update_mail_content
    @mail_content = MailContent.find(1)
    if @mail_content.update_attributes(mail_params)
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
