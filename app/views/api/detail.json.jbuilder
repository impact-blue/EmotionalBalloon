json.date do
    json.extract! @product, :id, :name, :price,:image,:scenes,:charas,:colors,:balloontypes
end