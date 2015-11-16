class Color < ActiveRecord::Base
  has_many :product_colors
  has_many :products, through: :product_colors
end
