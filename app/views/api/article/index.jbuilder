json.articles @products do |article|
  json.(article, :id, :product)
end