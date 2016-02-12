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
#利用規約
  def edit_agreement
    @agreement = Agreement.find(1)
  end

  def update_agreement
    @agreement = Agreement.find(1)
    if @agreement.update_attributes(agreement_params)
      redirect_to '/admin'
    else
      render 'edit_agreement'
    end
  end
#特商法
  def edit_trade_rule
    @trade_rule = Traderule.find(1)
  end

  def update_trade_rule
    @trade_rule = Traderule.find(1)
    if @trade_rule.update_attributes(trade_rule_params)
      redirect_to '/admin'
    else
      render 'edit_trade_rule'
    end
  end

#会社概要
  def edit_company
    @company = Company.find(1)
  end

  def update_company
    @company = Company.find(1)
    if @company.update_attributes(company_params)
      redirect_to '/admin'
    else
      render 'edit_trade_rule'
    end
  end

  private

  def mail_params
    params.require(:mail_content).permit(:subject,:text)
  end

  def agreement_params
    params.require(:agreement).permit(:content)
  end

  def trade_rule_params
    params.require(:traderule).permit(:company,:supervisor,:postal_code,:address,:phone,:business_hours,:mail,:homepage,:price,:special_price,:payment_info,:delivery_deadline,:cancel_info)
  end

    def company_params
    params.require(:company).permit(:name,:postal_code,:address,:phone,:ceo,:foundation_day,:capital,:trade_name,:proper,:special_price,:cancel_info,:payment_info)
  end
end
