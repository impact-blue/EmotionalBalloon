json.articles @articles do |article|
  json.(article, :id, :title)
end