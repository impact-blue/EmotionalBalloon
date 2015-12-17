json.date do
  json.product_list(@products) do |product|
    json.extract! product, :id, :product, :price
  end
end