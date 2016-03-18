json.result "success" if @product.status == 1
json.result "failure" if @product.status == 0
json.message "非公開の商品です。"   if @product.status == 0
  json.data do
    json.product_detail do
      json.extract! @product, :id, :name, :price
      json.description @product.comment
      json.images(@product.images.ids.map {|id|  "/images/get_image?id=#{id}"})
  end
end
