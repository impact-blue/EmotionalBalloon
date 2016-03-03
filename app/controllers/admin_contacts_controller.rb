class AdminContactsController < ApplicationController

  def index
    @contact = Contact.all
  end

end
