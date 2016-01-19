class CategoryChild < ActiveRecord::Base
has_many :product_category_children
has_many :products, through: :product_category_child

belongs_to :category
end
