class AdminContactsController < ApplicationController

  def index
    @json_contact_list = Contact.all.page(params[:page]).per(@page).order("created_at asc")
    @contact = Contact.all
  end

  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(create_params)
      flash[:success] = "編集しました"
      redirect_to admin_contact_path, notice: '状態を変更しました。'
    else
      render 'index'
    end
  end

  private

  def create_params
    params.require(:contact).permit(:status)
  end

end
