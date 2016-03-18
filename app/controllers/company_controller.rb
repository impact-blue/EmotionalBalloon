class CompanyController < ApplicationController

  def contact
    @contact = Contact.new
  end

  def create_contact
     @contact = Contact.new(contact_params)
     @contact.status = "未対応"
     if @contact.save
      Mailer.thanks_contact(@contact).deliver
      redirect_to root_path
    else
      render 'contact'
    end
  end


  private

  def contact_params
    params.require(:contact).permit(:email,:name,:content,:subject)
  end

end