class AdminMailsController < ApplicationController
before_action :logged_in_admin_user

  def edit
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
