module ApplicationHelper

  def canonical
    if params[:page].present?
       return request.path
    else
       return request.fullpath
    end
  end

end
