class CompanyController < ApplicationController

  def contact
    @contact = Contact.new
  end

  def create_contact
     @contact = Contact.new(contact_params)
     if @contact.save
      redirect_to root_path
    else
      render 'contact'
    end
  end


  private

  def contact_params
    params.require(:contact).permit(:email,:name,:content)
  end

end