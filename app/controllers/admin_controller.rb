class AdminController < ApplicationController

  http_basic_authenticate_with :name => "impact", :password => "impact1234"

  def index
  end

  def edit
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end

end