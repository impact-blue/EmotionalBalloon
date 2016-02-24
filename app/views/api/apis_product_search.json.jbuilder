json.data do
json.current_page(@current_page)
json.max_page(@products.num_pages)
  json.product_list(@products) do |product|
    json.extract! product, :id, :name, :price,:scenes,:charas
  end
end