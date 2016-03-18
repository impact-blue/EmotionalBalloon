class AdminContactsController < ApplicationController
  before_action :logged_in_admin_user
  before_action :set_json_index

  def index
    unless params[:status].present?
      redirect_to "/admin/contacts?status=all"
    end

    if params[:per_page].present?
      @per = params[:per_page]
    end

    if params[:status] == "all"
    @json_contact_list = Contact.all.page(params[:page]).per(@per).order("created_at desc")
    elsif params[:status] == "uncomplete"
      @json_contact_list = Contact.where(status: "未対応").page(params[:page]).per(@per).order("created_at desc")
    elsif params[:status] == "complete"
      @json_contact_list = Contact.where(status: "対応済み").page(params[:page]).per(@per).order("created_at desc")
    end
  end

  def edit
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
