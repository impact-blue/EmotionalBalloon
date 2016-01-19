class ProductCategoryChild < ActiveRecord::Base
  belongs_to :product
  belongs_to :category_child
end
