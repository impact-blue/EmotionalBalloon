class ImagesController < ApplicationController
skip_before_filter :verify_authenticity_token

  def index
    @images = Image.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images }
    end
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(create_params)
    @image.image =params[:image][:image].read
    @image.image_content_type = params[:image][:image].content_type
    if @image.save
      redirect_to action: 'index'
    else
      render new
    end
  end

  def get_image
    @image = Image.find(params[:id])
    send_data(@image.image, :disposition => "inline", :type => "image/png")
  end

  def api

    params[:file].each do |image|
      @image = Image.new
      @image.image = image[1].read
      @image.image_content_type = image[1].content_type
      @image.save
    end

    if @image.save
      redirect_to action: 'index'
    else
      render new
    end
  end

  private
  def create_params
    params.require(:image).permit(:name)
  end

end