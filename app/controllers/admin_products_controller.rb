class AdminProductsController < ApplicationController
  before_action :logged_in_admin_user
  before_action :set_json_index,:set_json_categories
  skip_before_filter :verify_authenticity_token ,only:[:import]

  def new
    @product = Product.new
  end


  def index
    #全商品個数の表示
    #@product_count = Product.count
    #unless params[:status].present?
    #  redirect_to "/admin/products?status=all"
    #end

    # params[:target][:id,order,stocks][:list][:category]

    if params[:per_page].present?
      @per = params[:per_page]
    end


    if params[:status] == "all"
      @json_products = Product.get_list_all_page(params[:page],@per).order("#{params[:target]} #{params[:order]}")
    elsif params[:status] == "public"
      @json_products = Product.get_list_public(params[:page],@per).order("#{params[:targer]} #{params[:order]}")
    elsif params[:status] == "secret"
      @json_products = Product.get_list_secret(params[:page],@per).order("#{params[:target]} #{params[:order]}")
    elsif params[:status] == "none"
      @json_products = Product.get_list_no_stocks(params[:page],@per).order("#{params[:targer]} #{params[:order]}")
    end

    if params[:category].present?
      unless params[:category] == "0"
        @json_products = @json_products.where(category_id: params[:category])
      end
    end
    #CSVダウンロード
    #<a href="/admin/products.csv/?status=all&page={{data.search_products.current_page}}">CSV</a>
    respond_to do |format|
      format.html and return
      format.csv do
        send_data render_to_string, filename: "products-#{Time.now.to_date.to_s}.csv", type: :csv
      end
    end
  end

  def edit
    @json_detail_product = Product.includes(:category).find(params[:id])
  end

  def create
    @product = Product.new(create_params)
    if @product.save
      redirect_to "/admin/products?status=all" , notice: '商品の追加が完了しました。'
    else
      render action: 'new'
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(create_params)
      flash[:success] = "編集しました"
      redirect_to admin_products_path, notice: '商品の編集が完了しました。'
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to admin_products_path
  end

  def api
    if params[:data][:id] == "null"
      @product = Product.new(product_params)
      if Product.last.nil?
        @product.id = 1
      elsif Product.last.present?
        @product.id = (Product.last.id + 1)
      end
      @product.count = 0
    elsif params[:data][:id].present?
      @product = Product.find(params[:data][:id])
     # @json_detail_product = Product.find(params[:id])
    end
    @product.name         = params[:data][:name]
    @product.price        = params[:data][:price]
    @product.stocks       = params[:data][:stock]
    @product.comment      = params[:data][:description]
    @product.size         = params[:data][:size]
    @product.status       = params[:data][:status]
    @product.category_id  = params[:data][:category]

    if params[:data][:images].present?
       params[:data][:images].each_with_index do |product_info,i|
          unless product_info[1].class == String
            @product.images.build
            @product.images[i].product_id = @product.id
            @product.images[i].image = product_info[1].read
            @product.images[i].image_content_type = product_info[1].content_type
          end
      end
    elsif params[:data][:images].blank? #画像がない場合のエラーメッセージ
      return render json: {data:
                            {result:"false",
                              "message":
                              @product.errors.full_messages.each do |msg|
                                ["msg"]
                              end
                            }
                          }
    end
    #保存

    if @product.save
      render json: {data:{result:"success"}}
    else
      render json: {data:
                      {result:"false",
                        "message":
                        @product.errors.full_messages.each do |msg|
                          ["msg"]
                        end
                      }
                   }
    end
  end

  def import
    Product.import(params[:file])
    redirect_to "/admin/products?status=all"
  end


  private

  def create_params
    params.require(:product).permit(:name,:price,:stocks,:comment,:recommended,:keyword,:boxsize_id,:registration_date,{:scene_ids =>[]},{:color_ids =>[]},{:chara_ids =>[]},{:balloon_type_ids =>[]})
  end

  def product_params
#    params = ActionController::Parameters.new(JSON.parse(request.body.read))
    params.require(:data).permit(:id)
  end

end
