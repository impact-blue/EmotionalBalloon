class AdminContactsController < ApplicationController
  before_action :logged_in_admin_user
  before_action :set_json_index

  def index
    @json_contact_list = Contact.all.page(params[:page]).per(@page).order("created_at asc")
    @contact = Contact.all
  end

  def edit
    @contact = Contact.find(params[:id])
    @json_detail_contact = Contact.find(params[:id])
  end

  def api
    @contact = Contact.find(params[:data][:id])
    @contact.status = params[:data][:status]
    if @contact.save
      render json: {data:{result:"success"}}
    else
      render json: {data:{result:"false"}}
    end
  end

  private

  def create_params
    params.require(:contact).permit(:status)
  end

end
