class Category < ActiveRecord::Base
  has_one :product, through: :product_category
  has_one :product_category
end
