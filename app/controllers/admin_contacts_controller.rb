class AdminContactsController < ApplicationController

  def index
    @contact = Contact.all
  end

  def edit
    @contact = Contact.find(params[:id])
  end

end
