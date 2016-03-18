json.result "success" if @product.status == 1
json.result "failure" if @product.status == 0
json.message "非公開の商品です。"   if @product.status == 0
  json.data do
    json.product_detail do
      json.extract! @product, :id, :name, :price
      json.description @product.comment
      json.image "/admin/images/get_image?id=#{@product.images[0].id}"
    end
  end
