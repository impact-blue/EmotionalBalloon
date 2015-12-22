class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  #商品詳細ページ、発送ページ、利用規約、下層
  def set_request_filter
     Thread.current[:request] = request
  end
end